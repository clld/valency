class ArgumentType < ActiveRecord::Base
  self.primary_key = :id
  
  has_many :coding_frame_index_numbers

  attr_accessible :argument_type, :description, :comment, :id
end
