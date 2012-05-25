class CodingFrameIndexNumber < ActiveRecord::Base
  belongs_to :coding_set
  belongs_to :coding_frame
  belongs_to :argument_type
  attr_accessible :index_number, :coding_set_id, :coding_frame_id, :argument_type_id
end
 