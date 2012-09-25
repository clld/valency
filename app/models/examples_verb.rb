class ExamplesVerb < ActiveRecord::Base
  # attr_accessible :example_id, :verb_id

  belongs_to :example
  belongs_to :verb

end
