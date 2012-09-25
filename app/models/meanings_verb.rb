class MeaningsVerb < ActiveRecord::Base
  # attr_accessible :meaning_id, :verb_id

  belongs_to :meaning
  belongs_to :verb

end
