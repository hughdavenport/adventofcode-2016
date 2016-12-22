lines = File.readlines(ARGV[0]).map(&:chomp)

a_ord = 'a'.ord

lines.each do |line|
  enc, id, _ = line.scan(/(.*)-(\d+)\[(.*)\]/)[0]
  chars = enc.chars
  shift = id.to_i % 26
  dec = chars.map do |c|
    c == '-' ? ' ' : (((c.ord - a_ord) + shift) % 26 + a_ord).chr
  end.join
  if dec == "northpole object storage"
    puts id
    break
  end
end
