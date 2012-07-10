class Microrole < ActiveRecord::Base
  belongs_to :meaning
  
  attr_accessible :id, :name, :original_or_new, :role_letter, :meaning_id
end
