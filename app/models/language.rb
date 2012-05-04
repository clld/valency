class Language < ActiveRecord::Base
  attr_accessible :family, :id, :iso_code, :name, :variety
end
