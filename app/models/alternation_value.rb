class AlternationValue < ActiveRecord::Base
  self.primary_key = :id
  attr_accessible :alternation_comment, :alternation_occurs, :verb_id, :alternation_id, :id, :derived_coding_frame_id

  belongs_to :verb
  belongs_to :alternation
  belongs_to :derived_coding_frame, class_name: 'CodingFrame', inverse_of: :alternation_values
  
  has_and_belongs_to_many :examples
  
  validates_uniqueness_of :verb_id, scope: :alternation_id
  
end
