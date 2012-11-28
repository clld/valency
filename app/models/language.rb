class Language < ActiveRecord::Base
  self.primary_key = :id
#  attr_accessible :family, :id, :iso_code, :name, :variety, :alternation_occurs_judgement_criteria, :characterization_of_flagging_resources, :characterization_of_indexing_resources, :characterization_of_ordering_resources, :comments, :continent, :latitude, :longitude, :name_for_url, :data_sources_generalizations_contributor_backgrounds

  has_many :alternations
  has_many :coding_frames
  has_many :coding_sets
  has_many :gloss_meanings
  has_many :verbs
  has_many :examples

  has_many :contributions
  has_many :contributors, through: :contributions, source: :person
  
  default_scope order(:name)
  
  # generate helper methods for gmaps4rails
  acts_as_gmappable process_geocoding: false
  
  # allows using just @language instead of @language.name in views
  def to_s
    name
  end
  
  # readable URL parameter: language name
  def to_param
    name_for_url
  end
  
  # make the continent available under different name
  def region
    self.continent
  end
  
  # dom_is replacement for the language's region
  def region_id
    "region-#{self.region.match(/\w+/).to_s.downcase}"
  end
  
  # return the list of contributors (as Person objects),
  # ordered by contributions.sort_order_number
  def get_contributors
    Person.joins(:languages).where(contributions:{language_id: self.id}, contributor: 'True').order('contributions.sort_order_number ASC')
  end
  
  def contributor_count
    self.contributors.where(contributor: 'True').count
  end
  
end
