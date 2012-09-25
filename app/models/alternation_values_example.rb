class AlternationValuesExample < ActiveRecord::Base
  # attr_accessible :example_id, :alternation_value_id

  belongs_to :example
  belongs_to :alternation_value

end
