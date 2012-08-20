class VerbsController < ApplicationController
  before_filter :get_language
  
  def get_language
    @language = Language.includes(:verbs).find(params[:language_id])
  end
  
  # GET /languages/1/verbs
  # GET /languages/1/verbs.json
  def index
    @verbs = @language.verbs.includes(:coding_frame, :meanings).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @verbs }
    end
  end

  # GET /languages/1/verbs/1
  # GET /languages/1/verbs/1.json
  def show
    @verb = @language.verbs.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @verb }
    end
  end

end
