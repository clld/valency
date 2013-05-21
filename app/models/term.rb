class Term < ActiveRecord::Base
  self.primary_key = :id
  
  # attr_accessible :definition, :description, :term, :see_also
end
