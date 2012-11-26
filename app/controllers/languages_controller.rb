class LanguagesController < ApplicationController

  # GET /languages
  # GET /languages.json
  def index
    # get alphabetical list of "continents" (geographical regions)
    @languages = Language.includes(:contributors).all
    # this sorts regions alphabetically but we might need them in custom order
    @regions   = Language.unscoped.select(:continent).order(:continent).uniq.pluck(:continent)
    # custom order
    rr = @regions
    @regions_custom = [rr[0], rr[2], rr[4], rr[1], rr[3]]
    
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
