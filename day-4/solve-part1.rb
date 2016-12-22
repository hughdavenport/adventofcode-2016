class Symbol
  def call(*args, &block)
    ->(caller, *rest) { caller.send(self, *rest, *args, &block) }
  end
end

lines = File.readlines(ARGV[0]).map(&:chomp)

sum = 0

lines.each do |line|
  enc, id, check = line.scan(/(.*)-(\d+)\[(.*)\]/)[0]
  chars = enc.gsub('-', '').chars
  counts = chars.uniq.map { |c| [chars.count(c), c] }.sort { |a, b| [b[0], a[1]] <=> [a[0], b[1]] }
  correct = counts.first(5).map(&:[].(1)).join
  sum += id.to_i if check == correct
end

puts sum
