directions = File.read(ARGV[0]).chomp.split(", ")
x = 0
y = 0
d = 0
directions.each do |direction|
  turn = direction[0]
  moves = direction[1..-1].to_i
  d = (d + (turn == "R" ? 1 : -1)) % 4
  if d % 2 == 0
    y += (d < 2 ? 1 : -1) * moves
  else
    x += (d < 2 ? 1 : -1) * moves
  end
end

puts x.abs + y.abs
