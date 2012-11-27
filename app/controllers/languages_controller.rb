class LanguagesController < ApplicationController

  # GET /languages
  # GET /languages.json
  def index
    # get alphabetical list of "continents" (geographical regions)
    @languages = Language.includes(:contributors).all
    # this sorts regions alphabetically but we might need them in custom order
    @regions   = @languages.map{|l| l.region}.uniq.sort
    # custom order
    rr              = @regions
    @regions_custom = [rr[0], rr[2], rr[4], rr[1], rr[3]]
    
    # prepare data for gmaps4rails' gmaps helper
    @map_data = @languages.to_gmaps4rails do |lang, marker|
      marker.infowindow render_to_string(
        partial: 'map_infowindow', object: lang, as: 'language'
      )
      marker.title lang.to_s
      # marker.sidebar "I am the sidebar"
      # marker.picture({picture: "path/to/picture.png", width:32, height:32})
      marker.json({
        id:     dom_id(lang),
        region: lang.region_id
      })
    end
    @google_api_key ||= ENV['GOOGLE_API_KEY']
    
    
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
