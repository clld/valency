class AlternationValuesExample < ActiveRecord::Base
  belongs_to :example
  belongs_to :alternation_value
  attr_accessible :example_id, :alternation_value_id
end
