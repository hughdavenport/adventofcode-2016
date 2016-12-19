lines = File.readlines(ARGV[0]).map(&:chomp)

keypad = [[nil,nil, 1 ,nil,nil],
          [nil, 2 , 3 , 4 ,nil],
          [ 5 , 6 , 7 , 8 , 9 ],
          [nil,"A","B","C",nil],
          [nil,nil,"D",nil,nil]]

x = 0
y = 2

lines.each do |line|
  directions = line.split("")
  directions.each do |direction|
    case direction
    when "U"
      y -= 1 unless y == 0 || keypad[y-1][x].nil?
    when "R"
      x += 1 unless x == keypad[y].length - 1 || keypad[y][x+1].nil?
    when "D"
      y += 1 unless y == keypad.length - 1 || keypad[y+1][x].nil?
    when "L"
      x -= 1 unless x == 0 || keypad[y][x-1].nil?
    end
  end
  print keypad[y][x]
end
