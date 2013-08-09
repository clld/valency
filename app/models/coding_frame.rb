class CodingFrame < ActiveRecord::Base
  self.primary_key = :id
  # attr_accessible :coding_frame_schema, :comment, :description, :id, :language_id, :derived
  PLACEHOLDER = "replace me!"
  DERIVED     = "Derived"
  REGULARLY   = "Regularly"

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
  
  # get basic Microroles of this Coding frame for a given set of Meanings
  def basic_microroles meanings
    self.microroles.joins(:meaning).where_meaning(meanings).uniq
  end
  
  # get a join association including Coding frame index numbers,
  # Microroles, Coding sets, and Argument types for this CF
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
  def idx_no_to_microrole(meaning)
    pairs = self.coding_frame_index_numbers.map do |cfin|
      mrole = cfin.microroles.where_meaning(meaning).uniq.first
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
    return self.verbs.size unless self.derived?
    self.related_verb_ids.size
  end
  
  # get Verbs related to this Coding frame – either as basic CF or vial alternations (only "Regularly")
  def related_verbs
    if self.derived?
      Verb.where id: related_verb_ids
    else
      self.verbs
    end    
  end

  # for a derived Coding frame, include the basic coding frames in the query
  def related_verbs_with_basic_cf
    Verb.includes(:coding_frame).where id: related_verb_ids
  end
  
  # get verb IDs of this Coding frame’s verbs (related either as basic Coding frame or via alternation values)
  def related_verb_ids
    if self.derived?
      @related_verb_ids ||= AlternationValue.where(alternation_occurs: REGULARLY, derived_coding_frame_id: self.id)
      .uniq.pluck :verb_id
    else
      @related_verb_ids ||= self.verbs.pluck(:id)
    end
  end
  
  # query database for meanings of all verbs associated with this CF
  # return array of arrays [meaning, [verb, verb, ...]]
  # (one per unique meaning)
  def get_meanings_and_verbs
    # Meanings are ordered by meaning label (default scope in meaning.rb)
    mm = Meaning.joins(:verbs).where('verbs.id' => self.related_verb_ids).uniq
    mm.map{|m| [m, m.verbs & self.related_verbs]}
  end
  
  # query database for Derived Coding frames related to this Basic Coding frame
  # via alternations, or Basic coding frames of verbs related to this
  # Derived coding frame
  def related_coding_frames
    unless derived? # get derived Coding frames
      CodingFrame.joins(:alternations)
        .where(:alternation_values => {:verb_id => related_verb_ids})
        .order("coding_frames.id").uniq
    else # get basic Coding frames
      self.related_verbs_with_basic_cf.map{|v| v.coding_frame}.uniq
    end
  end
      
end
