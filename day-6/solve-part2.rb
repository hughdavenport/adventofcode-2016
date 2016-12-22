inputs = File.readlines(ARGV[0]).map(&:chomp).map(&:chars).transpose

inputs.each do |input|
  print input.uniq.map { |c| [input.count(c), c] }.sort.first[1]
end
