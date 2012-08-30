class Microrole < ActiveRecord::Base
  self.primary_key = :id
  attr_accessible :id, :name, :name_for_url, :original_or_new, :role_letter, :meaning_id

  belongs_to :meaning

  has_many :verb_coding_frame_microroles
  has_many :verbs,         :through => :verb_coding_frame_microroles
  has_many :coding_frames, :through => :verb_coding_frame_microroles
  
  has_many :indexed_coding_frames, through: :microrole_index_numbers, source: :coding_frame_id

  has_and_belongs_to_many :coding_frame_index_numbers
  
  def to_s
    name
  end
  
  # readable URL parameter: microrole-name
  def to_param
    name_for_url
  end
  
end
