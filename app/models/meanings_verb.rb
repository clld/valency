class MeaningsVerb < ActiveRecord::Base
  belongs_to :meaning
  belongs_to :verb
  attr_accessible :title, :body, :meaning_id, :verb_id
end
