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
    @map_data = get_map_data @languages
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @languages }
    end
  end
  
  # GET /languages/1
  # GET /languages/1.json
  def show
    @language        = Language.find_by_name_for_url(params[:id])
    @iso_code        = @language.iso_code
    @contributors    = @language.get_contributors
    @native_speakers = @language.get_native_speakers

    @map_data = get_map_data @language
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @language }
    end
  end

  # prepare data for gmaps4rails' gmaps helper
  def get_map_data language_set
    @google_api_key ||= ENV['GOOGLE_API_KEY']
    
    language_set.to_gmaps4rails do |lang, marker|
      marker.infowindow render_to_string(
        partial: 'map_infowindow', object: lang, as: 'language'
      )
      marker.title lang.to_s
      # marker.sidebar "I am the sidebar"
      marker.picture({
        picture: "http://wals.info/static/wals/images/icons/cff0.png",
        width:  32,
        height: 32
      })
      marker.json({
        id:     dom_id(lang),
        region: lang.region_id
      })
    end

  end
  

end
