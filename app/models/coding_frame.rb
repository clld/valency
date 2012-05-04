class CodingFrame < ActiveRecord::Base
  belongs_to :language
  attr_accessible :coding_frame_schema, :comment, :description, :id
end
