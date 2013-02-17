class VerbCodingFrameMicrorole < ActiveRecord::Base
  #attributes :microrole_id, :verb_id, :coding_frame_id 
  belongs_to :verb
  belongs_to :microrole
  belongs_to :coding_frame

end
