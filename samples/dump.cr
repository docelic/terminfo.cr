#!/usr/bin/env crystal

require "../src/terminfo"

unless term_name = ENV["TERM"]?
  raise "No terminal set in environment variable TERM."
end

ti = Terminfo.from_term term_name

puts "--> Terminal names:"
ti.names.each do |name|
  puts "  - #{name}"
end
puts

puts "--> Terminfo bools:"
ti.booleans.each_key do |idx|
  key = Terminfo::KeyNames::Booleans[idx][:full]
  puts "  #{key}"
end
puts

puts "--> Terminfo numbers:"
ti.numbers.each do |idx, value|
  key = Terminfo::KeyNames::Numbers[idx][:full]
  puts "  #{key} = #{value}"
end
puts

puts "--> Terminfo strings:"
ti.strings.each do |idx, bytes|
  key = Terminfo::KeyNames::Strings[idx][:full]
  puts "  #{key} = #{String.new(bytes).inspect}"
end

