# This script finds all gloss abbreviation without a corresponding meaning
# in examples and gloss_meanings, and writes the whole nine yards to a CSV file

# boot Rails app environment
require File.expand_path('../../config/environment',  __FILE__)

results = [["language_id", "Language", "abbrev", "example_id"]] # array to store the lines in
Re = /(?<![[:alpha:]])([A-Z]+)(?![[:alpha:]])/ # single run of caps


print "Scanning database... "
Language.all.each do |lang|
  
  abbrevs = lang.gloss_meanings_hash
  missing_abbrevs = Hash.new

  lang.examples.each do |ex|
    next if ex.gloss.blank?
    ex.gloss.scan(Re).each do |chunk|
      abbr = chunk[0]
      next if abbrevs[abbr] && !abbrevs[abbr].blank?
      missing_abbrevs[abbr] ||= ex.id
    end
  end

  missing_abbrevs.each_pair do |abbr, ex_id|
    results << [lang.id, lang.name, abbr, ex_id]
  end
  
end
puts "done!"

filename = 'abbrevs.csv'
print "Writing to file #{filename}... "
File.open(filename, 'r+') do |f|
  results.each do |line|
    f.puts line.join ', '
  end
end
puts "done!"

`open #{filename}`