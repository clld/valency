class Language < ActiveRecord::Base
  attr_accessible :family, :id, :iso_code, :name, :variety, :alternation_occurs_judgement_criteria, :characterization_of_flagging_resources, :characterization_of_indexing_resources, :characterization_of_ordering_resources, :comments, :data_sources_generalizations_contributor_backgrounds
end
