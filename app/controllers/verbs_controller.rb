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
    @examples = @verb.examples_of_coding_frame
    @excount  = @examples.size

    # flash[:notice] ="Hello World!"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @verb }
    end
  end

end