class Microrole < ActiveRecord::Base
  ORIGINAL = "Original role"

  self.primary_key = :id
  # attr_accessible :id, :name, :name_for_url, :original_or_new, :role_letter, :meaning_id
  default_scope joins(:meaning) # had to remove .order("meanings.label") because of PostgreSQL
  
  filter_by_meanings = lambda do |m|
    meaning_ids = if m.respond_to? :pluck then m.pluck(:id) else m.id end
    where meaning_id: meaning_ids
  end
  
  scope :where_meaning, filter_by_meanings

  belongs_to :meaning

  has_many :verb_coding_frame_microroles
  has_many :verbs,         :through => :verb_coding_frame_microroles
  has_many :coding_frames, :through => :verb_coding_frame_microroles
  
  has_many :indexed_coding_frames, through: :coding_frame_index_numbers, source: :coding_frame

  has_and_belongs_to_many :coding_frame_index_numbers
  
  def to_s
    name
  end
  
  # readable URL parameter: microrole-name
  def to_param
    name_for_url
  end
  
  # count all verbs associated with this Microrole
  def verb_count
    self.verb_coding_frame_microroles.pluck(:verb_id).uniq.size
  end
  
  # count all verbs associated with this Microrole
  def coding_frame_count
    self.verb_coding_frame_microroles.pluck(:coding_frame_id).uniq.size
  end
  
  # return '0' if it's an Original role, '1' otherwise (for sorting in view)
  def sort_prefix
    if self.original_or_new == ORIGINAL then '0' else '1' end
  end

end
