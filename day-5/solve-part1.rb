require 'digest'
md5 = Digest::MD5.new

input = File.read(ARGV[0]).chomp

append = 0
password = ""

while password.length < 8
  hex = md5.hexdigest("#{input}#{append}")
  password += hex[5] if hex[0..4] == "00000"
  append += 1
end

puts password
