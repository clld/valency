class CodingFramesController < ApplicationController
  before_filter :get_language

  def get_language
    @language = Language.includes(:coding_frames).find_by_name_for_url(params[:language_id])
  end
  
  # GET /languages/russian/coding_frames[.json]
  def index
    @coding_frames = @language.coding_frames.includes(:verbs => :meanings)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coding_frames }
    end
  end

  # GET /languages/russian/coding_frames/1[.json]
  def show
    # get coding frame
    @coding_frame = @language.coding_frames.find(params[:id])

    mroles            = @coding_frame.microroles
    @cf_index_numbers = @coding_frame.coding_frame_index_numbers.includes(:microroles)

    # only Basic Coding frames have Verbs associated with them
    unless @coding_frame.derived?
      @verbs = @coding_frame.verbs.includes(:meanings)
    end
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coding_frame }
    end
  end
    
end
