directions = File.read(ARGV[0]).chomp.split(", ")
x = 0
y = 0
d = 0
visited = []
catch :found do
  directions.each do |direction|
    turn = direction[0]
    moves = direction[1..-1].to_i
    d = (d + (turn == "R" ? 1 : -1)) % 4
    moves.times do
      if d % 2 == 0
        y += (d < 2 ? 1 : -1)
      else
        x += (d < 2 ? 1 : -1)
      end
      throw :found if visited.include?([x,y])
      visited << [x,y]
    end
  end
end

puts x.abs + y.abs
