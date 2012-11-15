class CodingFrameIndexNumber < ActiveRecord::Base
  self.primary_key = :id
  # attr_accessible :id, :index_number, :coding_set_id, :coding_frame_id, :argument_type_id
  default_scope order :index_number

  belongs_to :coding_set
  belongs_to :coding_frame
  belongs_to :argument_type

  has_and_belongs_to_many :microroles
  
  validates_uniqueness_of :coding_frame_id, scope: :index_number
  
end
