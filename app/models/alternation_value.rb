class AlternationValue < ActiveRecord::Base
  OCCURS_VALUES = ['Marginally','Never','Regularly']
  NO_DATA       = 'No data'
  NO_DATA_REPR  = '-'

  self.primary_key = :id
  # attr_accessible :comment, :alternation_occurs, :verb_id, :alternation_id, :id, :derived_coding_frame_id

  belongs_to :verb
  belongs_to :alternation
  belongs_to :derived_coding_frame, class_name: 'CodingFrame', inverse_of: :alternation_values
  
  has_and_belongs_to_many :examples
  
  validates_uniqueness_of :verb_id, scope: :alternation_id
  
  # return "No data" for other values
  def occurs
    if (val = self.alternation_occurs)
      val.capitalize!
      return val if OCCURS_VALUES.include? val
      return NO_DATA_REPR if val == NO_DATA
      nil
    end
  end
  
  # get a readable tooltip title
  def title
    if OCCURS_VALUES.include? (val = self.occurs)
      val
    elsif val == NO_DATA_REPR
      NO_DATA
    else
      nil
    end
  end
  
end
