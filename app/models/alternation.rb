class Alternation < ActiveRecord::Base
  belongs_to :language
  attr_accessible :alternation_name, :alternation_type, :coding_frames_of_alternation, :description, :id
end
