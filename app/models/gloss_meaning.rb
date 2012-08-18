class GlossMeaning < ActiveRecord::Base
  self.primary_key = :id
  
  belongs_to :language

  attr_accessible :comment, :gloss, :id, :meaning, :language_id
end
