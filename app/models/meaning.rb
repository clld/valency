class Meaning < ActiveRecord::Base
  attr_accessible :id, :label, :meaning_list, :number, :role_frame, :typical_context
end
