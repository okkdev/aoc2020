puts IO.read("input.txt").split(/\s\s/).map { |s| s.gsub(/\s+/, "").split("").uniq }.flatten.length
