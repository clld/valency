class AlternationValue < ActiveRecord::Base
  belongs_to :verb
  belongs_to :alternation
  belongs_to :derived_coding_frame, class_name: 'CodingFrame', inverse_of: :alternation_values
  
  has_and_belongs_to_many :examples
  
  validates_uniqueness_of :verb_id, scope: :alternation_id
  
  attr_accessible :alternation_comment, :alternation_occurs, :verb_id, :alternation_id
  
end
