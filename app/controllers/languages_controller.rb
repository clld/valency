class LanguagesController < ApplicationController

  # GET /languages
  # GET /languages.json
  def index
    # get alphabetical list of "continents" (geographical regions)
    @languages = Language.includes(:contributors).all
    @regions   = Language.unscoped.select(:continent).order(:continent).uniq.pluck(:continent)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @languages }
    end
  end
  
  # GET /languages/1
  # GET /languages/1.json
  def show
    @language = Language.find_by_name_for_url(params[:id])
    @iso_code = @language.iso_code

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @language }
    end
  end

end
