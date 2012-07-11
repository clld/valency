class CodingFrameExample < ActiveRecord::Base
  belongs_to :example
  belongs_to :verb
  belongs_to :coding_frame
  
  attr_accessible :id, :example_id, :verb_id, :coding_frame_id
end
