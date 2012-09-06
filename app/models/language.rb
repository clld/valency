class Language < ActiveRecord::Base
  self.primary_key = :id
  attr_accessible :family, :id, :iso_code, :name, :variety, :alternation_occurs_judgement_criteria, :characterization_of_flagging_resources, :characterization_of_indexing_resources, :characterization_of_ordering_resources, :comments, :continent, :latitude, :longitude, :name_for_url, :data_sources_generalizations_contributor_backgrounds

  has_many :alternations
  has_many :coding_frames
  has_many :coding_sets
  has_many :gloss_meanings
  has_many :contributors, through: :contributions, source: :person_id
  has_many :verbs
  has_many :examples
  
  # allows using just @language instead of @language.name in views
  def to_s
    name
  end
  
  # readable URL parameter: language name
  def to_param
    name_for_url
  end
  
  
end
