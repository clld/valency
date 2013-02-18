class MicrorolesController < ApplicationController
  # GET /microroles
  # GET /microroles.json
  def index
    @microroles = Microrole.includes(:verb_coding_frame_microroles).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @microroles }
    end
  end

  # GET /microroles/1
  # GET /microroles/1.json
  def show
    @microrole = Microrole.find_by_name_for_url(params[:id])
    @meaning   = @microrole.meaning
    @verbs     = @microrole.verbs
    @coding_frames = @microrole.coding_frames
    @index_numbers = @microrole.coding_frame_index_numbers
    
    @cf_to_in = Hash[ @coding_frames.map do |cf|
      [cf, (cf.coding_frame_index_numbers & @index_numbers).uniq.first || nil]
    end ]
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @microrole }
    end
  end

end
