class Example < ActiveRecord::Base
  belongs_to :language
  belongs_to :reference
  belongs_to :person

  has_and_belongs_to_many :alternation_values
  has_and_belongs_to_many :verbs
  
  attr_accessible :analyzed_text, :comment, :type, :number, :gloss, :id, :media_file_name, :media_file_timecode, :original_orthography, :primary_text, :reference_pages, :translation, :translation_other, :language_id, :reference_id, :person_id

end
