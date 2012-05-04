class AlternationValuesExample < ActiveRecord::Base
  belongs_to :alternation
  belongs_to :example
  # attr_accessible :title, :body
end
