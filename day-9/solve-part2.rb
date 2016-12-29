input = File.read(ARGV[0]).chomp.chars

def solve(chunk)
  index = chunk.index('(')
  return chunk.length unless index
  length = chunk[index..-1].index(')')
  num, repeat = chunk[(index + 1)..(index + length - 1)].join.split('x').map(&:to_i)
  new_chunk = chunk[(index + length + 1)..(index + length + 1 + num - 1)]

  rest = chunk[(index + length + 1 + num)..-1]

  index + repeat * solve(new_chunk) + solve(rest)
end

puts solve(input)
