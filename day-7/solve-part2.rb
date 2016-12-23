def matches(thing)
  thing.chars.each_cons(3).select do |slice|
    slice[0] == slice[2] && slice[0] != slice[1]
  end
end

input = File.readlines(ARGV[0]).map(&:chomp)

sum = 0

input.each do |ip|
  hypernets = ip.scan(/\[(.*?)\]/).flatten
  hypernet_matches = hypernets.map { |hypernet| matches(hypernet) }.flatten(1).map(&:uniq)
  fields = ip.scan(/\]?(\w+)\[?/).flatten - hypernets
  field_matches = fields.map { |field| matches(field) }.flatten(1).map(&:uniq)
  sum += 1 unless (field_matches & hypernet_matches.map(&:reverse)).empty?
end

puts sum
