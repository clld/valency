# Database connection settings for RFM
RFM_CONFIG = {
  host:         'brugmann.eva.mpg.de',  # IP address: 194.94.96.174
  database:     'Valency',              # database name
  account_name: 'script',               # the user is read-only, has XML access
  password:     'ruby-rfm',
  ssl:          false,
  root_cert:    false,
  port:         80,                     # 443 with SSL doesn't seem to work
  timeout:      20
}

# nonstandard layout names:
special_layouts = {
	Contribution              => "Language_contributors (table)",
	MeaningsVerb              => "Verb_meanings (table)",
	ExamplesVerb              => "Verb_examples (table)",
	AlternationValuesExample  => "Alternation_value_examples (table)",
	CodingFrameExample	      => "Verb_coding_frame_examples (table)"
}
spec_lay = ->(obj){ special_layouts[obj] }

# nonstandard field names:
special_field_names = {
	Alternation => {
		'coding_frames_text' => 'coding_frames_of_alternation'
	},
	AlternationValue => {
		'id' 								 => 'z_calc_Unique_key_decimal'
	},
	AlternationValuesExample => {
		'alternation_value_id' => 'Alternation_values::z_calc_Unique_key_decimal'
	},
	GlossMeaning => {
		'comment' => 'Gloss_meaning_comments::comments'
	}
}
spec_fields = ->(obj){ special_field_names[obj] }

def get_layout(model, spec_lay)
	def layout_or_nil(layout_name)
		begin
			layout = Rfm.layout(layout_name) # raises exc. if layout_name not a string
			layout.table # raises exc. if layout does not exist
			layout
		rescue
			nil
		end
	end
	special = spec_lay.call(model)
	unless special.nil?
		layout = layout_or_nil(special)
	else
		layout = layout_or_nil(model.to_s.tableize + ' (table)')
	end
		raise "Layout \"#{special}\" does not exist." if layout.nil?
		return layout
end

# helper methods: appends prefix and suffix to FM field name
class String
	def css_field_name
		"z_calc_#{self.to_s}_as_css"
	end
	def prefixed_field_name(model)
		"#{model.to_s.underscore}_#{self}"
	end
end

def get_field_names(model, attribute_names, layout, spec_fields)
  field_names = layout.field_names.map{|name| name.downcase} # existing field names
  attr_to_field = {} # hash to be returned: field names for the attributes
  attribute_names.each do |attr_name| # for each of the model's attributes

    # look for special name
    special_name_exists = false
    if spec_fields.call(model) && spec_fields.call(model).include?(attr_name)
      source_field = spec_fields.call(model)[attr_name]
      special_name_exists = true
      if not field_names.include? source_field # special name misspelled
        puts "WARNING: Layout \"#{layout.name}\" does not have a field \"#{source_field}\"."
        special_name_exists = false
      end
    end

    unless special_name_exists
      # try with prefixed model name
      source_field = attr_name.prefixed_field_name(model) # e.g. name ==> language_name
      if not field_names.include? source_field
        # try _as_css version
        source_field = attr_name.css_field_name
        if not field_names.include? source_field
          # try both
          source_field = attr_name.prefixed_field_name(model).css_field_name
          if not field_names.include? source_field
            # assume unchanged
            source_field = attr_name
          end
        end  
      end
    end
    
   	# try with plural:
    unless field_names.include? source_field
    	attr_name_pl = attr_name.pluralize
      # try with prefixed model name
      source_field = attr_name_pl.prefixed_field_name(model) # e.g. name ==> language_name
      if not field_names.include? source_field
        # try _as_css version
        source_field = attr_name_pl.css_field_name
        if not field_names.include? source_field
          # try both
          source_field = attr_name_pl.prefixed_field_name(model).css_field_name
          if not field_names.include? source_field
            # assume unchanged
            source_field = attr_name_pl
          end
        end  
      end
    end
    
    if not field_names.include? source_field 
      puts "WARNING: Cannot find a source field for #{model.to_s}.#{attr_name}!"
      next
    else
      # store it in the hash
      puts "#{attr_name} <-- #{source_field}"
      attr_to_field[attr_name] = source_field
    end
  end
  return attr_to_field
end


# Gather all model classes:
rails_models = Dir[Rails.root.join 'app','models','*.rb'].map do |file|
	File.basename(file,'.*').camelize.constantize
end

log = Rails.root.join('db', 'seeds.log')
m.attribute_names.map{|x|"  #{x}"}.join("\n")}

File.open(log, 'w+') do |errlog|


    print "deleting #{classname} records... "; cls.delete_all
    puts "OK"

    end # done looping through lines of one file
    puts "\n#{classname}: #{cls.count} records created. #{errcount > 0 ? 'There were '+errcount.to_s : 'No'} errors."
  end # done looping through files
end