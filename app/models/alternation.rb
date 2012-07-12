class Alternation < ActiveRecord::Base
  belongs_to :language
  has_many :alternation_values
  has_many :verbs,    :through => :alternation_values
  has_many :examples, :through => :alternation_values # I wonder if this will work
  
  attr_accessible :name, :type, :coding_frames_text, :description, :id, :language_id, :complexity
end
