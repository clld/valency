class Example < ActiveRecord::Base
  self.primary_key = :id
  # attr_accessible :analyzed_text, :comment, :example_type, :number, :gloss, :id, :media_file_name, :media_file_timecode, :original_orthography, :primary_text, :reference_pages, :translation, :translation_other, :language_id, :reference_id, :person_id
  default_scope order :number

  belongs_to :language
  belongs_to :reference
  belongs_to :person
  
  has_many :alternation_values_examples
  has_many :coding_frame_examples
  has_many :coding_frames, :through => :coding_frame_examples

  has_and_belongs_to_many :alternation_values
  has_and_belongs_to_many :verbs  
  
  # get first Meaning of first related Verb of this Example
  def get_meaning
    unless self.verbs.empty?
      self.verbs.first.meanings.first
    end
  end
  
  # find out what the example exemplifies: a Basic Coding frame, an Alternation, or Other
  def exemplifies
    if self.alternation_values_examples.any?
      self.alternation_values.first.alternation
    elsif self.coding_frame_examples.any?
      self.coding_frames.first
    elsif self.verbs.any?
      self.verbs.first
    else
      "other"
    end
  end
  
end
