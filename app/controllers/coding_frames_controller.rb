class CodingFramesController < ApplicationController
  before_filter :current_language
  def current_language
    @current_language = Language.find cookies[:current_language_id] rescue nil
  end

  def get_language
    @language = Language.includes(:coding_frames).find_by_name_for_url(params[:language_id])
    cookies[:current_language_id] = @language.id
  end
  
  # GET /coding_frames[.json]
  # GET /languages/russian/coding_frames[.json]
  def index
    if params[:language_id]
      get_language # sets @language variable      
      @coding_frames = @language.coding_frames.includes(:verbs => :meanings)
    else # no language given
      @coding_frames = CodingFrame.includes(:language, :verbs).all
    end

    # argument counts of the coding frames
    @arg_counts = @coding_frames.map do |cf|
      cf.arg_count unless cf.nil? || cf.coding_frame_schema.blank?
    end
    @arg_counts.uniq!
    @arg_counts.keep_if{|x|x} # reject nil values
    @arg_counts.sort!
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coding_frames }
    end
  end

  # GET /languages/russian/coding_frames/1[.json]
  def show
    get_language
    @coding_frame = @language.coding_frames.includes(:microroles).find(params[:id]) # get coding frame

    mroles            = @coding_frame.microroles
    @cf_index_numbers = @coding_frame.coding_frame_index_numbers.includes(:microroles, :coding_set)

    @verbs   = @coding_frame.related_verbs.includes(:meanings)
    verb_ids = @coding_frame.related_verb_ids
    @related_coding_frames = @coding_frame.related_coding_frames

    if @coding_frame.derived?
      @alternations_of_related_cf = Hash[
        @related_coding_frames.map do |cf|
          [ cf,
            Alternation.joins(:alternation_values)
              .where(:alternation_values => {
                :derived_coding_frame_id => @coding_frame.id, :verb_id => verb_ids
              }).uniq
          ]
        end
      ]
    else
      @alternations_of_related_cf = Hash[
        @related_coding_frames.map{ |cf| [cf, cf.alternations_of_derived_cf] }
      ]
    end
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coding_frame }
    end
  end
    
end
