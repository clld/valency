class VerbCodingFrameMicrorole < ActiveRecord::Base
  belongs_to :verb
  belongs_to :microrole
  belongs_to :coding_frame
  # attr_accessible :title, :body
end
