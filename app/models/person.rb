class Person < ActiveRecord::Base
  self.primary_key = :id
  # attr_accessible :contributor, :id, :name, :native_speaker, :url

  has_many :contributions
  has_many :languages, through: :contributions
  
  def to_s
    self.name
    # (self.name.gsub!(/\s+/,'&nbsp;') || name).html_safe
    # rejected this hack – do it with CSS instead
  end

end
