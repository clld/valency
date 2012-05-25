class GlossMeaning < ActiveRecord::Base
  belongs_to :language
  attr_accessible :comment, :gloss, :id, :meaning, :language_id
end
