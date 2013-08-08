class CodingFrame < ActiveRecord::Base
  self.primary_key = :id
  # attr_accessible :coding_frame_schema, :comment, :description, :id, :language_id, :derived
  PLACEHOLDER = "replace me!"
  DERIVED     = "Derived"

  belongs_to :language

  has_many :verbs
  
  has_many :alternation_values, foreign_key: "derived_coding_frame_id", inverse_of: :derived_coding_frame
  has_many :alternations, :through => :alternation_values

  has_many :coding_frame_index_numbers
  has_many :coding_sets,    :through => :coding_frame_index_numbers
  has_many :argument_types, :through => :coding_frame_index_numbers

  has_many :coding_frame_examples
  has_many :examples,    :through => :coding_frame_examples

  has_many :verb_coding_frame_microroles
  has_many :microroles,  :through => :verb_coding_frame_microroles
  
  has_many :coding_frame_index_numbers

  # string representation
  def to_s
    self.coding_frame_schema unless self.coding_frame_schema == PLACEHOLDER
  end
  
  # treat "replace me!" as empty; normalize whitespace
  def coding_frame_schema
    return @cfs if @cfs
    @cfs = self[:coding_frame_schema]
    unless @cfs.respond_to?(:match) && @cfs.match(/replace me/i)
      @cfs.gsub!(/\s+/,' ')
      @cfs.gsub!(/\s*(<|>)\s*/, ' \\1 ')
      @cfs
    end
  end
  
  # get basic Microroles of this Coding frame
  # for a given set of Meanings
  def basic_microroles meanings
    self.microroles.joins(:meaning).where_meaning(meanings).uniq
  end
  
  # get a join association including Coding frame index numbers,
  # Microroles, Coding sets, and Argument types for this CF
  # @args meanings – set of meanings to limit microroles to
  def index_numbers_eager_load
    self.coding_frame_index_numbers.includes(
      :argument_type, :coding_set, :microroles
    )
  end
  
  # return true if the coding frame is derived
  def derived?
    self.derived == DERIVED
  end

  # Helper method. Returns a Hash from CodingFrameIndexNumbers (ActiveRecord obj.)
  # to Microroles (ActiveRecord obj.) given a Meaning
  # Only call if all associations are cached!
  # See coding_frames_controller#show
  def idx_no_to_microrole(m)
    pairs = self.coding_frame_index_numbers.map do |cfin|
      mrole = cfin.microroles.where_meaning(m).uniq.first
      unless (mrole.nil? || mrole.name.blank?)
        [cfin, mrole]
      end
    end
    pairs.keep_if{|x|x} # discard nil values
    Hash[pairs]
  end
  
  # count the number of distinct arguments for sorting (maximum: 9 – for dataTable filters)
  def arg_count
    @arg_count ||= self[:coding_frame_schema].nil? ? 9 : self[:coding_frame_schema].scan(/\d+/).uniq.size
  end
  
  # count the verbs that have this coding frame as their basic coding frame
  # or that occur regularly in an alternation with this CF as the derived CF
  def verb_count
    return self.verbs.count unless self.derived?
    self.verb_ids_of_derived_cf.uniq.size
  end
  
  # query database for meanings of all verbs associated with this basic CF
  # return array of arrays [meaning, [verb, verb, ...]]
  # one per unique meaning
  def get_meanings_and_verbs
    # Meanings will be ordered by meaning label (default scope in meaning.rb)
    mm = Meaning.joins(:verbs).where('verbs.coding_frame_id' => self[:id]).uniq
    mm.map{|m| [m, m.verbs & self.verbs]}
  end
  
  # query database for Derived Coding frames related to this Basic Coding frame via alternations
  # only returns useful results for a Basic coding frame
  def derived_coding_frames
    self.class.joins(:alternations)
      .where(:alternation_values => {:verb_id => self.verb_ids.uniq})
      .order("coding_frames.id").uniq
  end
  
  # query database for Basic Coding frames related to this Derived Coding frame via alternations
  def basic_coding_frames
    self.verbs_of_derived_cf.map{|v|v.coding_frame}.uniq
  end
  
  # query database for the IDs of verbs related to this Coding frame via alternations
  def verb_ids_of_derived_cf
    AlternationValue.where(alternation_occurs: "Regularly", derived_coding_frame_id: self.id)
    .pluck(:verb_id)
  end
  
  # find the Verbs related to this Coding frame via alternations (only "Regularly")
  def verbs_of_derived_cf
    Verb.includes(:coding_frame).where id: verb_ids_of_derived_cf
  end
  
  

end
