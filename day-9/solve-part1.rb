input = File.read(ARGV[0]).chomp.chars
output = []

index = 0
while index < input.length
  char = input[index]
  if char == '('
    length = input[index..-1].index(')')
    inside = input[(index + 1)..(index + length - 1)]
    num, repeat = inside.join.split('x').map(&:to_i)
    index += length + 1
    chunk = input[index..(index + num - 1)]
    repeat.times { output << chunk }
    index += num
  else
    output << char
  end
end
output.flatten!

puts output.length
