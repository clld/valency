class CodingFrameExample < ActiveRecord::Base
  # attr_accessible :example_id, :verb_id, :coding_frame_id

  belongs_to :example
  belongs_to :verb
  belongs_to :coding_frame
  
end
