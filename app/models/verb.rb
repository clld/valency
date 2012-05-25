class Verb < ActiveRecord::Base
  belongs_to :language
  belongs_to :coding_frame
  has_many :alternations, :through => :alternation_values
  has_many :examples_for_coding_frame, :class_name => "Example", :through => :coding_frame_examples
  has_and_belongs_to_many :examples
  has_and_belongs_to_many :meanings
  attr_accessible :comment, :id, :original_script, :verb_form, :language_id, :coding_frame_id
end
