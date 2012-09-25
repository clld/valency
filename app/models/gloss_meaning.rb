class GlossMeaning < ActiveRecord::Base
  self.primary_key = :id
  # attr_accessible :comment, :gloss, :id, :meaning, :language_id
  
  belongs_to :language

end
