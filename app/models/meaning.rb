class Meaning < ActiveRecord::Base
  self.primary_key = :id
  # attr_accessible :id, :label, :label_for_url, :meaning_list, :number, :role_frame, :typical_context
  CORE = ['Core list', 'Extended list']
  CORE_STRING  = 'core'
  OTHER_STRING = 'additional'
  
  has_many :microroles
  has_and_belongs_to_many :verbs

  default_scope order(:label)
  scope :core, where(meaning_list: CORE)
  
  def to_s
    label
  end
  
  # readable URL parameter: meaning-label
  def to_param
    label_for_url
  end

  def core_or_additional
    return CORE_STRING if CORE.include? self.meaning_list
    OTHER_STRING
  end
  
  def role_count
    self.role_frame.scan(/[A-Z]/).uniq.size if self.role_frame
  end
  
  # Helper method. Returns a Hash from CodingFrameIndexNumber objects to
  # Microrole objects given a CodingFrame.
  # Only call if all associations are cached!
  # See meanings_controller#show, coding_frames_controller#show
  def cf_index_number_to_microrole(cf)
    return {} if cf.coding_frame_schema.blank?
    pairs = cf.coding_frame_index_numbers.map do |cfin|
      mrole = cfin.microroles.where_meaning(self).uniq.first
      unless (mrole.nil? || mrole.name.blank?)
        [cfin, mrole]
      end
    end
    pairs.keep_if{|x|x} # discard nil values
    Hash[pairs]
  end
  
  # calls the cf_index_number_to_microrole method and converts the result
  # to a simpler Hash (plain Integers mapped to Microrole names)
  def idx_no_to_microrole_name(cf)
    Hash[cf_index_number_to_microrole(cf).map{ |i,mr| [i.index_number, mr.name] }]
  end
  
end
