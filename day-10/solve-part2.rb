instructions = File.readlines(ARGV[0]).map(&:chomp).map(&:split)

rules = []
bots = {}
outputs = []

def place(val, place, bots, outputs)
  dst = place[:dst] == "bot" ? bots : outputs
  dst[place[:num]] = [] unless dst[place[:num]]
  dst[place[:num]] << val
end

instructions.each do |split|
  if split[0] == "value"
    bot = split[-1].to_i
    bots[bot] = [] unless bots[bot]
    bots[bot] << split[1].to_i
  else
    bot = split[1].to_i
    low = {:dst => split[5], :num => split[6].to_i}
    high = {:dst => split[10], :num => split[11].to_i}
    rules[bot] = {:low => low, :high => high}
  end
end

until (to_act = bots.select { |bot, vals| vals.length == 2}).empty?
  to_act.each do |bot, vals|
    low = rules[bot][:low]
    high = rules[bot][:high]
    vals = vals.sort

    place(vals[0], low, bots, outputs)
    place(vals[-1], high, bots, outputs)
    bots[bot] = []
  end
end

puts outputs[0..2].map(&:first).inject(&:*)
