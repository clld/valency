class Alternation < ActiveRecord::Base
  belongs_to :language
  attr_accessible :name, :type, :coding_frames_text, :description, :id, :language_id
end
