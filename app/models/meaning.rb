class Meaning < ActiveRecord::Base
  self.primary_key = :id
  attr_accessible :id, :label, :label_for_url, :meaning_list, :number, :role_frame, :typical_context
  
  has_many :microroles
  has_and_belongs_to_many :verbs

  def to_s
    label
  end
  
  # readable URL parameter: meaning-label
  def to_param
    label_for_url
  end

  def microroles_commalist
    self.microroles.all.map{|mr| mr.to_s}.join(', ')
  end
  
end
