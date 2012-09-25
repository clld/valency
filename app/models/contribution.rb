class Contribution < ActiveRecord::Base
  # attr_accessible :sort_order_number, :language_id, :person_id

  belongs_to :language
  belongs_to :person
  
end
