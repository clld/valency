class Verb < ActiveRecord::Base
  self.primary_key = :id
  attr_accessible :comment, :id, :original_script, :verb_form, :language_id, :coding_frame_id

  belongs_to :language
  belongs_to :coding_frame
  
  has_and_belongs_to_many :examples
  has_and_belongs_to_many :meanings

  has_many :alternation_values
  has_many :alternations,                   :through => :alternation_values
  has_many :alternation_values_examples,    :through => :alternation_values
  has_many :examples_of_alternation_values, :through => :alternation_values_examples, :source => :example_id

  has_many :coding_frame_examples
  has_many :examples_of_coding_frame, :through => :coding_frame_examples, :source => :example

  has_many :verb_coding_frame_microroles
  has_many :microroles,         :through => :verb_coding_frame_microroles
    
  # allows using just @verb instead of @verb.verb_form in views
  def to_s
    self.verb_form
  end
  
end