class CodingSet < ActiveRecord::Base
  belongs_to :language
  has_many :coding_frames, :through => :coding_frame_index_numbers
  attr_accessible :comment, :id, :name, :language_id
end
