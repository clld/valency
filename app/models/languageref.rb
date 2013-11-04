class Languageref < ActiveRecord::Base
  self.primary_key = :id
#  attr_accessible , :id, :name, :nodata

  has_many :alternations    ,:dependent => :destroy
  has_many :coding_frames   ,:dependent => :destroy
  has_many :coding_sets     ,:dependent => :destroy
  has_many :gloss_meanings  ,:dependent => :destroy
  has_many :verbs           ,:dependent => :destroy
  has_many :examples        ,:dependent => :destroy

  has_many :contributions
  has_many :contributors, through: :contributions, source: :person
  
  default_scope order(:name)

  # allows using just @language instead of @language.name in views
  def to_s
    name
  end
  
  
end
