class Verb < ActiveRecord::Base
  self.primary_key = :id
  # attr_accessible :comment, :id, :original_script, :verb_form, :language_id, :coding_frame_id

  validates_presence_of :verb_form, :on => :create, :message => "can't be blank"

  belongs_to :language
  belongs_to :coding_frame
  
  has_and_belongs_to_many :examples
  has_and_belongs_to_many :meanings

  has_many :alternation_values
  has_many :alternations,                   :through => :alternation_values

  has_many :coding_frame_examples
  has_many :examples_of_coding_frame, :through => :coding_frame_examples, :source => :example

  has_many :verb_coding_frame_microroles
  has_many :microroles,         :through => :verb_coding_frame_microroles
    
  # allows using just @verb instead of @verb.verb_form in views
  def to_s
    verb_form
  end
  
  # readable URL parameter: id-verb-form
  def to_param
    id.to_s + '-' + verb_form.parameterize
  end
  
  def coding_frame?
    self.coding_frame && !self.coding_frame.coding_frame_schema.blank?
  end
  
  def av_comments?
    self.alternation_values.any?{|av| av.comment}
  end

  # alias to get the coding frame
  def cframe
    self.coding_frame
  end
  
  # get new microroles introduced by alternations (w/o using those alternations)
  def derived_microroles
    self.microroles.uniq - self.coding_frame.basic_microroles(self.meanings)
  end
  
  
end