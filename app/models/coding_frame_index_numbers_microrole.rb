class CodingFrameIndexNumbersMicrorole < ActiveRecord::Base
  belongs_to :coding_frame_index_number
  belongs_to :microrole

  attr_accessible :coding_frame_index_number_id, :microrole_id
end
