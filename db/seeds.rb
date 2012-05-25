#!/Users/alexanderjahraus/.rvm/bin/rvm-auto-ruby
puts "# ruby "+ RUBY_VERSION
########### only needed for testing in TextWrangler:
ruby_v = `$HOME/.rvm/bin/rvm current`.chomp
# point ruby to the correct Gem directory...
ENV['GEM_HOME']       = File.join Dir.home, '.rvm/gems', ruby_v
ENV['BUNDLE_GEMFILE'] = File.join Dir.home, 'work/valency/Gemfile'
ENV['GEM_PATH']       = ENV['GEM_HOME'] +':'+ File.join(Dir.home, '.rvm/gems', ruby_v+'@global')
# Load and initialize the rails application
require File.join Dir.home, 'work/valency/config/application'
require 'rfm'
Valency::Application.initialize!
###########

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

Logfile = Rails.root.join('db', 'seeds.log') # logfile name

# helper methods: appends prefix and suffix to FM field name
class String
	def css_field_name
		"z_calc_#{self.to_s}_as_css"
	end
	def prefixed_field_name(model)
		"#{model.to_s.underscore}_#{self}"
	end
end

class FieldFinder
 	attr_reader :model, :layout, :log, :field_names

  def initialize(model, logfile)
  	@model = model
  	@log = logfile
		@special_layout = {
			Contribution              => "Language_contributors (table)",
			MeaningsVerb              => "Verb_meanings (table)",
			ExamplesVerb              => "Verb_examples (table)",
			AlternationValuesExample  => "Alternation_value_examples (table)",
			CodingFrameExample	      => "Verb_coding_frame_examples (table)"
		}
		@special_field_name = { # nonstandard field names (must be in lowercase!):
			Alternation => {
				'coding_frames_text' => 'coding_frames_of_alternation'
			},
			AlternationValue => {
				'id' 								 => 'z_calc_unique_key_decimal'
			},
			AlternationValuesExample => {
				'alternation_value_id' => 'alternation_values::z_calc_unique_key_decimal'
			},
			GlossMeaning => {
				'comment' => 'gloss_meaning_comments::comments'
			},
			Example => {
				'person_id' => 'source_person_id'
			},
			Meaning => {
				'meaning_list' => 'z_calc_meaning_list_core_extended_new_or_old'
			}
		}
		@layout = find_layout
		@field_names = find_field_names		
	end
	
	def name_transformations # expects a block, yields lambdas to it
		def compose(f,g) # compose 2 lambdas
			->(x) { f.call(g.call(x)) }
		end
		pl  = ->(s) { s.singularize == s ? s.pluralize : s.singularize } # toggle plural
		css = ->(s) { s.css_field_name } # z_calc_field_name_as_css
		pre = ->(s) { s.prefixed_field_name(@model) } # model_field_name
		yield compose(css, compose(pre, pl))
		yield compose(css, pre)
		yield compose(css, pl)
		yield compose(pre, pl)
		yield css
		yield pre
		yield pl
		yield ->(s){s} # identity: no change
	end

	def layout_or_nil(layout_name)
		begin
			if (layout = Rfm.layout(layout_name)).table then layout; end
		rescue nil
		end
	end

	def find_layout
		l_name = @special_layout[@model] || @model.to_s.tableize + ' (table)'
		if layout = layout_or_nil(l_name)
			@log << "\n==== Model: #{@model.to_s} <– Layout: #{layout.name} ===="
			return layout
		else 
			@log << "WARNING: Layout \"#{l_name}\" does not exist."
			return nil
		end
	end
	
	def find_field_names
		return nil if @layout.nil?
		attr_names = @model.attribute_names.map{|name| name.downcase}
	  fm_fields  = @layout.field_names.map{|name| name.downcase} # layout's fields
		result = {} # hash to be returned: field names for the attributes
		
		attr_names.each do |attr_name| # for each of the model's attributes

			if special = @special_field_name[@model] && f_name = special[attr_name]
				if fm_fields.include? f_name
					result[attr_name] = f_name
				else 
					@log << "WARNING: Field \"#{f_name}\" not found on layout \"#{@layout.name}\"."				
					next
				end
			else # no special field name: guess regular field name
				name_transformations do |transf|
					if fm_fields.include? (transformed = transf.call(attr_name))
						result[attr_name] = transformed
						break
					end
				end
			end
	
			if result[attr_name].nil?
				@log << "WARNING: No field found for #{@model.to_s}.#{attr_name}"
			else
				@log << "OK: #{attr_name} <-- #{result[attr_name]}"
			end
		
		end
		return result
	end
    
end # of class

class DataImporter
	attr_reader :models, :field_names, :log, :ff # FieldFinder instance

	def initialize
		# Gather all model classes:
		@models = Dir[Rails.root.join 'app','models','*.rb'].map do |file|
			File.basename(file,'.*').camelize.constantize
		end
	end

	def import_data
	  @log = File.open(Logfile, 'a')# 'a' is for append
		
		@models.each do |model|
			puts '='.center(30,'=')
	    print "deleting #{model.to_s} records... "; model.delete_all
		  puts "OK"

 			# get the layout and field names
 			@ff = FieldFinder.new(model, @log)
			next if (layout = @ff.layout).nil? or (fields = @ff.field_names).empty?
 			puts "Connecting to FileMaker, layout=#{layout.name}..."
 			puts "Importing data into #{model.to_s.tableize}"
			
			# now loop through the records of the layout
			layout.all.each do |record|
				new_obj = {}
				(model.attribute_names & fields.keys).each do |attr_name|
					new_obj[attr_name] = fields[attr_name]							
				end #loop over attribute names
				model.create new_obj
				print '.'
			end #loop over records

		end #loop over models
		
		@log.close
	end
	
end # of class
