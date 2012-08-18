class Meaning < ActiveRecord::Base
  self.primary_key = :id
  
  has_many :microroles
  has_and_belongs_to_many :verbs
  
  attr_accessible :id, :label, :meaning_list, :number, :role_frame, :typical_context 
end
