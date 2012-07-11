class VerbCodingFrameMicrorole < ActiveRecord::Base
  belongs_to :microrole
  belongs_to :verb
  belongs_to :coding_frame
  
end
