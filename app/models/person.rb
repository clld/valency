class Person < ActiveRecord::Base
  self.primary_key = :id
  # attr_accessible :contributor, :id, :name, :native_speaker, :url, :affiliation, :photo_url, :email

  has_many :contributions
  has_many :languages, through: :contributions
  
  def to_s
    self.name
  end

end
