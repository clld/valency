class ArgumentType < ActiveRecord::Base
  self.primary_key = :id
  attr_accessible :argument_type, :description, :comment, :id
  
  has_many :coding_frame_index_numbers

  def to_s
    self.argument_type
  end
end
