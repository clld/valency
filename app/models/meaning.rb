class Meaning < ActiveRecord::Base
  self.primary_key = :id
  attr_accessible :id, :label, :meaning_list, :number, :role_frame, :typical_context 
  
  has_many :microroles
  has_and_belongs_to_many :verbs

  def to_s
    self.label
  end

end
