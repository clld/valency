class ExamplesVerb < ActiveRecord::Base
  belongs_to :example
  belongs_to :verb

  attr_accessible :example_id, :verb_id
end
