puts IO.read("input.txt").split(/\s\s/).map{ |s| s.split(/\s+/).map{ |s| s.split("") } }.map { |i| i.flatten.tally.select{ |_, n| n == i.size }.size }.sum
