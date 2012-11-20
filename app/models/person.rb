class Person < ActiveRecord::Base
  self.primary_key = :id
  # attr_accessible :contributor, :id, :name, :native_speaker, :url

  has_many :contributions
  has_many :languages, through: :contributions

end
