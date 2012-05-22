# Delete all reccords of every model
# Read and parse tab-separated file, use column headers as field names,
# create records with values from the file

require_relative './rfm_models'

def is_number?(str) # helper method to check if a string can be converted to a number
  true if Float(str) rescue false
end

log = File.join(data_dir, 'import.log')

File.open(log, 'w+') do |errlog|
  Dir.glob(File.join(data_dir, '*' + ext)).each do |filename|
    classname = File.basename(filename, ext)
    classname = classname[0].capitalize + classname[1..-1]
    begin
      cls = Kernel.const_get(classname)
    rescue NameError
      puts "Class \"#{classname}\" not found."
      next
    end
  
    print "deleting #{classname} records... "
    cls.delete_all
    puts "OK"

    puts "reading #{File.basename(filename)}..."
    linecount = errcount = 0
    keys = []
      
    File.foreach(filename) do |line|
      line.chomp! # remove trailing newline
      if linecount == 0 # first line: read the keys
        keys = line.split("\t").map! {|k| k.to_sym } # :symbols
        puts 'Keys: '+(keys.map {|k| k.inspect}).join(', ')
      elsif line.match(/\t/) and not line.strip.empty?
        begin
          # hack: by appending "\tEND" to the line, we ensure that there are no nil values after split
          fields = (line+"\tEND").split("\t")
          valuesHash = {}
          for i in 0...keys.length
            unless fields[i].nil? or fields[i].empty?
              field = fields[i]
              field = field.to_i if is_number?(field) # converts number strings to integers!
              valuesHash[keys[i]] = field
            end
          end
          # Create the record
          cls.create(valuesHash) unless valuesHash.empty?
          print '.'
        rescue Exception => e
          print 'e'
          errcount += 1
          errlog << "#{filename}:#{linecount} #{e.message}\n"
        end 
      end
      linecount += 1
    end # done looping through lines of one file
    puts "\n#{classname}: #{cls.count} records created. #{errcount > 0 ? 'There were '+errcount.to_s : 'No'} errors."
  end # done looping through files
end