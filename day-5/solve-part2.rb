require 'digest'
md5 = Digest::MD5.new

input = File.read(ARGV[0]).chomp

append = 0
password = [nil] * 8

while password.compact.length < 8
  hex = md5.hexdigest("#{input}#{append}")
  password[hex[5].to_i] = hex[6] if hex[0..4] == "00000" && (0..7).map(&:to_s).include?(hex[5]) && password[hex[5].to_i].nil?
  append += 1
end

puts password.join
