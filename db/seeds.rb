# Find file names in the data directory, try convert them to class constants
# Delete all reccords of every model whose class name matches one of the files
# Read and parse tab-separated file, use column headers as field names,
# create records with values from the file

data_dir = File.join(Dir.home()+'/Desktop/data/') # set data directory
ext = '.csv' # file name extension of data
Dir.glob(data_dir + '*' + ext).each do |filename|
  classname = File.basename(filename, ext).capitalize
  begin
    cls = Kernel.const_get(classname)
  rescue NameError
    puts "Class \"#{classname}\" not found."
    next
  end
  
  puts "deleting #{classname} records..."
  cls.delete_all

  puts "reading #{File.basename(filename)}... "
  linecounter = 0
  keys = []
  lastError = ""
  
  File.foreach(filename) do |line|
    line.chomp! # remove trailing newline
    if linecounter == 0 # first line: read the keys
	    keys = line.split("\t").map! {|k| k.to_sym } # :symbols
	    puts 'Keys: '+(keys.map {|k| k.inspect}).join(', ')
	  elsif not line.empty? and line.match(/\t/)
  		begin
  		  fields = line.split("\t")
  		  valuesHash = {}
  		  for i in 0...keys.length
  		      field = fields[i].empty? ? "" : fields[i]
  		      field = field.to_i if field.to_i > 0
  		      valuesHash[keys[i]] = field
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
