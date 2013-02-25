# This script finds all gloss abbreviation without a corresponding meaning
# in examples and gloss_meanings, and writes the whole nine yards to a CSV file

# boot Rails app environment
APP_PATH = File.expand_path('../../config/application',  __FILE__)
require File.expand_path('../../config/boot',  __FILE__)

# Initialize the rails application
Valency::Application.initialize!

results = [["language_id", "Language", "abbrev", "example_id"]] # array to store the lines in
Re = /(?<![[:alpha:]])([A-Z]+)(?![[:alpha:]])/ # single run of caps

Language.all.each do |lang|
  
  abbrevs = lang.gloss_meanings_hash

  lang.examples.each do |ex|
    next if ex.gloss.blank?
    ex.gloss.scan(Re).each do |chunk|
      abbr = chunk[0]
      next if abbrevs[abbr] && !abbrevs[abbr].blank?
      results << [lang.id.to_s, lang.name, abbr, ex.id.to_s]
    end
  end
  
end

File.open('abbrevs.csv', 'r+') do |f|
  retults.each do |line|
    f.puts line.join ', '
  end
end