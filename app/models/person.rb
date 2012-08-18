class Person < ActiveRecord::Base
  self.primary_key = :id
  
  has_many :languages, through: :contributions

  attr_accessible :contributor, :id, :name, :native_speaker, :url
end
