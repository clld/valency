class VerbsController < ApplicationController
  before_filter :get_language
  
  def get_language
    @language = Language.includes(:verbs).find_by_name_for_url(params[:language_id])
  end
  
  # GET /languages/1/verbs
  # GET /languages/1/verbs.json
  def index
    @verbs       = @language.verbs.includes(:coding_frame, :meanings).all
    @orig_script = @verbs.any?{|v| v.original_script}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @verbs }
    end
  end
    
  # GET /languages/1/verbs/1
  # GET /languages/1/verbs/1.json
  def show
    @verb = @language.verbs.includes(:alternation_values,
    :coding_frame, :meanings, :microroles).find(params[:id])
    if (param_meaning = params[:meaning])
      @meaning = Meaning.find_by_label_for_url!(param_meaning) || nil
    end
    
    @examples = @verb.examples_of_coding_frame
    @excount  = @examples.size
    @gloss_abbr = Hash[@language.gloss_meanings.map{|gm| [gm.gloss, gm.meaning]}]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @verb }
    end
  end

end