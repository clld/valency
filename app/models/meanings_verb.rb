class MeaningsVerb < ActiveRecord::Base
  belongs_to :meaning
  belongs_to :verb
  attr_accessible :meaning_id, :verb_id
end
