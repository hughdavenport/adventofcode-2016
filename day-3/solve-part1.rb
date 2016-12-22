class Symbol
  def call(*args, &block)
    ->(caller, *rest) { caller.send(self, *rest, *args, &block) }
  end
end

puts File.readlines(ARGV[0]).map(&:chomp).map(&:split).map(&:map.(&:to_i)).count { |a,b,c| a + b > c && a + c > b && b + c > a }
