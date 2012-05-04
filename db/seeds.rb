# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# delete all records
[Language, Person, Meaning, Verb, CodingFrame, VerbToMeaning, PersonToLanguage].each do |cls|
  cls.delete_all
  
  filename = "/Users/alexanderjahraus/Desktop/data/"+cls.to_s+".csv"
  print "reading "+filename+"..."
  puts "OK" if File.exists? filename

  linecounter = 0
  keys = []
  lastError = ""
  
  File.foreach(filename) do |line|
    line.chomp! # remove trailing newline
    if linecounter == 0 # first line: read the keys
	  keys = line.split("\t").map! {|k| k.to_sym } # :symbols
	  puts (keys.map {|k| k.inspect}).join ", "
	elsif line != ""
		begin

		  fields = line.split("\t")
		  valuesHash = {}
		  for i in 0...keys.length
		    if fields[i] != ""
		      field = fields[i]
		      field = field.to_i if field.to_i > 0
		      valuesHash[keys[i]] = field
		    end
		  end
		  newObj = cls.new(valuesHash)
		  newObj.save
		rescue Exception => e
		  # skip this line 
		  if e.message != lastError
		    lastError = e.message
		    puts lastError
		  end
		end
	  
    end
    linecounter += 1
  end
  
end