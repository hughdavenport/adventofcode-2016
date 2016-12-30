require 'pqueue'
require 'set'

class Node
  attr_accessor :floors
  attr_accessor :lift
  attr_accessor :moves

  def initialize(filename)
    @floors = []
    lines = File.readlines(filename).map(&:chomp)
    @floors = lines.map do |line|
      line = line.split[4..-1].join(' ')
      line = line.gsub(/,? and/, ',').gsub(/ ?a /, "").gsub(".", "")
      things = line.split(/,( and)?/)
      {
        :generators => things.select { |thing| thing.split[1] == "generator" }.map { |thing| thing.split[0] },
        :microchips => things.select { |thing| thing.split[1] == "microchip" }.map { |thing| thing.split("-")[0] }
      }
    end
    @lift = 0
    @moves = 0
  end

  def neighbors
    floor = floors[lift]
    new_set = Set.new
    if lift > 0
      floor[:generators].each do |generator|
        node = clone
        node.moves += 1
        node.lift -= 1
        node.floors[lift][:generators].delete(generator)
        node.floors[node.lift][:generators] << generator
        new_set << node unless node.bad?
      end
      floor[:microchips].each do |microchip|
        node = clone
        node.moves += 1
        node.lift -= 1
        node.floors[lift][:microchips].delete(microchip)
        node.floors[node.lift][:microchips] << microchip
        new_set << node unless node.bad?
      end
    end
    if lift < 3
      floor[:generators].each do |generator|
        node = clone
        node.moves += 1
        node.lift += 1
        node.floors[lift][:generators].delete(generator)
        node.floors[node.lift][:generators] << generator
        new_set << node unless node.bad?
        floor[:generators].each do |generator2|
          next if generator == generator2
          node = clone
          node.moves += 1
          node.lift += 1
          node.floors[lift][:generators].delete(generator)
          node.floors[lift][:generators].delete(generator2)
          node.floors[node.lift][:generators] << generator
          node.floors[node.lift][:generators] << generator2
          new_set << node unless node.bad?
        end
      end
      floor[:microchips].each do |microchip|
        node = clone
        node.moves += 1
        node.lift += 1
        node.floors[lift][:microchips].delete(microchip)
        node.floors[node.lift][:microchips] << microchip
        new_set << node unless node.bad?
        floor[:microchips].each do |microchip2|
          next if microchip == microchip2
          node = clone
          node.moves += 1
          node.lift += 1
          node.floors[lift][:microchips].delete(microchip)
          node.floors[lift][:microchips].delete(microchip2)
          node.floors[node.lift][:microchips] << microchip
          node.floors[node.lift][:microchips] << microchip2
          new_set << node unless node.bad?
        end
      end
      floor[:generators].each do |generator|
        floor[:microchips].each do |microchip|
          node = clone
          node.moves += 1
          node.lift += 1
          node.floors[lift][:generators].delete(generator)
          node.floors[node.lift][:generators] << generator
          node.floors[lift][:microchips].delete(microchip)
          node.floors[node.lift][:microchips] << microchip
          new_set << node unless node.bad?
        end
      end
    end
    new_set
  end

  def finished?
    floors[0..2].all? { |floor| floor[:generators].empty? && floor[:microchips].empty? }
  end

  def bad?
    floors.any? { |floor| floor[:microchips].any? { |chip| ! floor[:generators].empty? && ! floor[:generators].include?(chip) } }
  end

  def ==(a)
    a.lift == lift &&
      a.sorted_floors == sorted_floors
  end

  def eql?(a)
    self == a
  end

  def hash
    sorted_floors.hash
  end

  def sorted_floors
    floors.map { |floor| floor.map { |sym, arr| [sym, arr.sort] }.to_h }
  end

  def <=>(a)
    a.distance <=> distance
  end

  def num_wrong
    floors[0..-2].each_with_index.map { |floor, index| (3 - index) * (floor[:generators].length + floor[:microchips].length) }.inject(&:+) * 2 + (lift - 3)
  end

  def distance
    moves + num_wrong
  end

  def clone
    super.tap { |new| new.floors = floors.map { |floor| { :generators => floor[:generators].clone, :microchips => floor[:microchips].clone } } }
  end
end

starting_node = Node.new(ARGV[0])

queue = PQueue.new([starting_node])
visited = Set.new([starting_node])

until queue.empty?
  node = queue.pop
  node.neighbors.each do |neighbor|
    if neighbor.finished?
      puts neighbor.moves
      exit
    end
    queue.push(neighbor) unless visited.include?(neighbor)
    visited << neighbor
  end
end
