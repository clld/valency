class CodingFrameIndexNumbersMicrorole < ActiveRecord::Base
  # attr_accessible :coding_frame_index_number_id, :microrole_id

  belongs_to :coding_frame_index_number
  belongs_to :microrole

end
