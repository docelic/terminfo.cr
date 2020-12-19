#!/usr/bin/env crystal

require "../src/terminfo"

unless term_name = ENV["TERM"]?
  STDERR.puts "No terminal set in environment variable TERM."
  exit 1
end

ti, db_path = Terminfo.from_term term_name
puts "Database file: #{db_path}"
puts

puts "--> Terminal names:"
ti.names.each do |name|
  puts "  - #{name}"
end
puts

puts "--> Terminfo boolean capabilities:"
ti.booleans.each_key do |bool_cap|
  puts "  #{bool_cap.long_name}"
end
puts

puts "--> Terminfo numeric capabilities:"
ti.numbers.each do |num_cap, value|
  puts "  #{num_cap.long_name} = #{value}"
end
puts

puts "--> Terminfo strings capabilities (sorted alphabetically):"
ti.strings.keys.sort_by(&.long_name).each do |str_cap|
  bytes = ti.strings[str_cap]
  puts "  #{str_cap.long_name} (#{str_cap.short_name}) = #{String.new(bytes).inspect}"
end
