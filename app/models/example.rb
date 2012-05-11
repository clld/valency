class Example < ActiveRecord::Base
  belongs_to :language
  belongs_to :reference
  belongs_to :person
  attr_accessible :analyzed_text, :comment, :gloss, :id, :media_file_name, :media_file_timecode, :original_orthography, :primary_text, :reference_pages, :translation, :translation_other, :language_id, :reference_id, :person_id

end
