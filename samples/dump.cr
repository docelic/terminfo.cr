#!/usr/bin/env crystal

require "../src/terminfo"

ti = Terminfo.parse!

puts "--> Terminal names:"
ti.names.each do |name|
  puts "  - #{name}"
end
puts

puts "--> Terminfo bools:"
ti.bools.each_key do |key|
  puts "  #{key}"
end
puts

puts "--> Terminfo numbers:"
ti.numbers.each do |key, value|
  puts "  #{key} = #{value}"
end
puts

puts "--> Terminfo strings:"
ti.strings.each do |key, bytes|
  puts "  #{key} = #{String.new(bytes).inspect}"
end
