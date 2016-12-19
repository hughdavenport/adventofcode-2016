lines = File.readlines("input-part1").map(&:chomp)

keypad = [[1,2,3],
          [4,5,6],
          [7,8,9]]

x = 1
y = 1

lines.each do |line|
  directions = line.split("")
  directions.each do |direction|
    case direction
    when "U"
      y -= 1 unless y == 0
    when "R"
      x += 1 unless x == keypad[y].length - 1
    when "D"
      y += 1 unless y == keypad.length - 1
    when "L"
      x -= 1 unless x == 0
    end
  end
  print keypad[y][x]
end
