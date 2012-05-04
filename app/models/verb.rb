class Verb < ActiveRecord::Base
  belongs_to :language
  belongs_to :coding_frame
  attr_accessible :comment, :id, :original_script, :verb_form, :language_id, :coding_frame_id
end
