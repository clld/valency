class VerbsController < ApplicationController
  before_filter :get_language
  
  def get_language
    @language = Language.includes(:verbs, :gloss_meanings).find_by_name_for_url(params[:language_id])
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
    @verb = @language.verbs.find(params[:id])
    if params[:meaning]
      @meaning  = Meaning.find_by_label_for_url!(params[:meaning]) || nil
      @synonyms = @meaning.verbs.where(language_id: @language.id) - [@verb]
    end
    
    @examples_of_cf = @verb.examples_of_coding_frame
    # @examples_other = @verb.examples - @examples_of_cf
    @gloss_abbr = @language.gloss_meanings_hash

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @verb }
    end
  end

end