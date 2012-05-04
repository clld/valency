class AlternationValuesExample < ActiveRecord::Base
  belongs_to :alternation
  belongs_to :example
  attr_accessible :alternation_id, :example_id
end
