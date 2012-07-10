class AlternationValue < ActiveRecord::Base
  belongs_to :verb
  belongs_to :alternation
  has_and_belongs_to_many :examples
  
  attr_accessible :alternation_comment, :alternation_occurs, :verb_id, :alternation_id
  
end
