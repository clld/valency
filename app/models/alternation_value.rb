class AlternationValue < ActiveRecord::Base
  belongs_to :verb
  belongs_to :alternation
  attr_accessible :alternation_comment, :alternation_occurs
end
