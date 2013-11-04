class Languageref < ActiveRecord::Base
  self.primary_key = :id
#  attr_accessible :family, :id, :iso_code, :name, :variety, :alternation_occurs_judgement_criteria, :characterization_of_flagging_resources, :characterization_of_indexing_resources, :characterization_of_ordering_resources, :comments, :continent, :latitude, :longitude, :name_for_url, :data_sources_generalizations_contributor_backgrounds

  has_many :alternations    ,:dependent => :destroy
  has_many :coding_frames   ,:dependent => :destroy
  has_many :coding_sets     ,:dependent => :destroy
  has_many :gloss_meanings  ,:dependent => :destroy
  has_many :verbs           ,:dependent => :destroy
  has_many :examples        ,:dependent => :destroy

  has_many :contributions
  has_many :contributors, through: :contributions, source: :person
  
  default_scope order(:name)
  
  # generate helper methods for gmaps4rails
  acts_as_gmappable process_geocoding: false
  
  # allows using just @language instead of @language.name in views
  def to_s
    name
  end
  
  
end
