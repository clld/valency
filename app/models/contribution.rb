class Contribution < ActiveRecord::Base
  belongs_to :language
  belongs_to :person
  attr_accessible :sort_order_number, :language_id, :person_id
end
