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

  def to_s
    self.coding_frame_schema
  end
  
  # treat "replace me!" as empty
  def coding_frame_schema
    cfs = self[:coding_frame_schema]
    cfs unless (cfs && cfs.match(/replace me/i))
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

end
