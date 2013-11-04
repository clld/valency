class CodingSetsController < ApplicationController
  before_filter :get_language
  
  def get_language
    @language = Language.includes(:coding_sets).find_by_name_for_url(params[:language_id])
    cookies[:current_language_id] = @language.id
  end
  
  # GET /languages/ainu/coding_sets[.json]
  def index
    @coding_sets = @language.coding_sets.includes(:coding_frame_index_numbers => :coding_frame)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coding_sets }
    end
  end

  # GET /languages/ainu/coding_sets/1[.json]
  def show
    @coding_set = @language.coding_sets.includes(:coding_frame_index_numbers => [:coding_frame, :microroles]).find(params[:id])
    @coding_frames = @coding_set.coding_frames

    # @cf_index_numbers = @coding_frames.coding_frame_index_numbers.includes(:microroles, :coding_set)
    # 
    # @verbs   = @coding_frames.related_verbs.includes(:meanings)
    # verb_ids = @coding_frames.related_verb_ids


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coding_sets }
    end
  end
  
  
end