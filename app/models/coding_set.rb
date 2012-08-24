class CodingSet < ActiveRecord::Base
  self.primary_key = :id
  attr_accessible :comment, :id, :name, :language_id

  belongs_to :language
  has_many :coding_frame_index_numbers
  has_many :coding_frames, :through => :coding_frame_index_numbers

  def to_s
    self.name
  end
end
