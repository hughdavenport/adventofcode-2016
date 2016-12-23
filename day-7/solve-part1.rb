def matches?(thing)
  thing && thing.chars.each_cons(4).any? do |slice|
    slice[0] == slice[3] && slice[1] == slice[2] && slice[0] != slice[1]
  end
end

input = File.readlines(ARGV[0]).map(&:chomp)

sum = 0

input.each do |ip|
  hypernets = ip.scan(/\[(.*?)\]/).flatten
  next if hypernets.any? { |hypernet| matches?(hypernet) }
  fields = ip.scan(/\]?(\w+)\[?/).flatten - hypernets
  sum += 1 if fields.any? { |field| matches?(field) }
end

puts sum
