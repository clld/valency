class MicrorolesController < ApplicationController
  # GET /microroles
  # GET /microroles.json
  def index
    @microroles = Microrole.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @microroles }
    end
  end

  # GET /microroles/1
  # GET /microroles/1.json
  def show
    @microrole = Microrole.find_by_name_for_url(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @microrole }
    end
  end

end
