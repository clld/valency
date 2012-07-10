class CodingFrame < ActiveRecord::Base
  belongs_to :language
  has_many :verbs

  has_many :coding_frame_index_numbers
  has_many :coding_sets, :through => :coding_frame_index_numbers

  has_many :coding_frame_examples
  has_many :examples,    :through => :coding_frame_examples

  attr_accessible :coding_frame_schema, :comment, :description, :id, :language_id
end
