class ArgumentType < ActiveRecord::Base
  has_many :coding_frame_index_numbers
  attr_accessible :argument_type, :description, :id
end
