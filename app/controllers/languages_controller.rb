class LanguagesController < ApplicationController

  # GET /languages
  # GET /languages.json
  def index
    # get alphabetical list of "continents" (geographical regions)
    @languages = Language.includes(:contributors).all
    cookies.delete :current_language_id # unset the cookie
    
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
  
  # GET /languages/glottolog
  def showViaGlottologCode
    @language = Language.find_by_glottolog_code(params[:id])
    if(@language.nil?)
      redirect_to('/languages')
      return
    end
    redirect_to("/languages/#{@language.name_for_url}")
  end

  # GET /languages/iso
  def showViaISOCode
    @language = Language.find_by_iso_code(params[:id])
    if(@language.nil?)
      redirect_to('/languages')
      return
    end
    redirect_to("/languages/#{@language.name_for_url}")
  end
  
  # GET /languages/1
  # GET /languages/1.json
  def show
    @language        = Language.includes(:verbs).find_by_name_for_url(params[:id])
    @language_ref    = Languageref.find_by_id(@language.id)
    if @language_ref.nil?
      @data_available = ""
    else
      @data_available = " (#{'%.1f' % (100-@language_ref.nodata)}% avail.)"
    end
    # if no language found then redirect to all languages page
    if(@language.nil?)
      redirect_to('/languages')
      return
    end
    cookies[:current_language_id] = @language.id
    @iso_code        = @language.iso_code
    @contributors    = @language.get_contributors
    @native_speakers = @language.get_native_speakers
    @refs            = Reference.where(language_id: @language.id).order('short_citation ASC')

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
      # if !lang.name.match(/(English|Ojibwe|Jaminjung|Balinese)/) #HJBB tentative
      # if !lang.name.match(/(Ojibwe)/) #HJBB tentative
        marker.infowindow render_to_string(
          partial: 'map_infowindow', object: lang, as: 'language'
        )
        marker.title lang.to_s
        # marker.sidebar "I am the sidebar"
        marker.picture({
          picture: '/assets/cf60.png',
          width:  32,
          height: 32,
          marker_anchor: [16, 16]
        })
        marker.json({
          id:     dom_id(lang),
          region: lang.region_id
        })
      # else
      #   l = lang
      #   l.name = "#{lang} (coming soon)"
      #   l.id = 0
      #   l.name_for_url = ''
      #   marker.infowindow render_to_string(
      #     partial: 'map_infowindow', object: l, as: 'language'
      #   )
      #   marker.title "#{lang}".to_s
      #   # marker.sidebar "I am the sidebar"
      #   marker.picture({
      #     picture: '/assets/cf60.png',
      #     width:  32,
      #     height: 32,
      #     marker_anchor: [16, 16]
      #   })
      #   marker.json({
      #     id:     dom_id(lang),
      #     region: lang.region_id
      #   })
      # end
    end

  end
  

end
