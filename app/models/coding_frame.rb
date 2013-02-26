class CodingFrame < ActiveRecord::Base
  self.primary_key = :id
  # attr_accessible :coding_frame_schema, :comment, :description, :id, :language_id, :derived

  belongs_to :language

  has_many :verbs
  has_many :alternation_values, foreign_key: "derived_coding_frame_id", inverse_of: :derived_coding_frame

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
    self.coding_frame_schema
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
    self.derived == 'Derived'
  end
  
  # count the number of distinct arguments for sorting
  def arg_count
    @arg_count ||= self[:coding_frame_schema].nil? ? 99 : self[:coding_frame_schema].scan(/\d+/).uniq.size
  end
  
  # count the verbs that have this basic coding frame
  def verb_count
    self.verbs.size
  end
  
  # query database for meanings of all verbs associated with this basic CF
  # return array of arrays [meaning, [verb, verb, ...]]
  # one per unique meaning
  def get_meanings_and_verbs
    # Meanings will be ordered by meaning label (default scope in meaning.rb)
    mm = Meaning.joins(:verbs).where('verbs.coding_frame_id' => self[:id]).uniq
    mm.map{|m| [m, m.verbs & self.verbs]}
  end

end
