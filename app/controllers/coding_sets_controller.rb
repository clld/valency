class CodingSetsController < ApplicationController
  before_filter :get_language
  
  def get_language
    @language = Language.includes(:coding_sets).find_by_name_for_url(params[:language_id])
  end
  
  # GET /languages/ainu/coding_sets[.json]
  def index
    @coding_sets = @language.coding_sets.includes(
      :coding_frame_index_numbers => [:coding_frames, :argument_type])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coding_frames }
    end
  end

  # GET /languages/ainu/coding_sets/1[.json]
  def show
    @coding_frame = @language.coding_frames.includes(:verbs).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coding_frame }
    end
  end
  
  
end