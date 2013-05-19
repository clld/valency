class CodingFramesController < ApplicationController

  def get_language
    @language = Language.includes(:coding_frames).find_by_name_for_url(params[:language_id])
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

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coding_frames }
    end
  end

  # GET /languages/russian/coding_frames/1[.json]
  def show
    get_language
    @coding_frame = @language.coding_frames.find(params[:id]) # get coding frame

    mroles            = @coding_frame.microroles
    @cf_index_numbers = @coding_frame.coding_frame_index_numbers.includes(:microroles, :coding_set)

    # only Basic Coding frames have Verbs associated with them
    if @coding_frame.derived?
      @verbs = @coding_frame.verbs_of_derived_cf
      verb_ids = @verbs.pluck(:id)
      @related_coding_frames = @coding_frame.basic_coding_frames
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
      @verbs = @coding_frame.verbs.includes(:meanings)
      @related_coding_frames = @coding_frame.derived_coding_frames.includes(:alternations)
      @alternations_of_related_cf = Hash[@related_coding_frames.map{ |cf| [cf, cf.alternations.uniq] }]
    end
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coding_frame }
    end
  end
    
end
