class AlternationsController < ApplicationController
  before_filter :get_language
  
  def get_language
    @language = Language.includes(:alternations).find_by_name_for_url(params[:language_id])
  end
  
  # GET /languages/1/alternations
  # GET /languages/1/alternations.json
  def index
    @alternations = @language.alternations.includes(:alternation_values, :verbs).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alternations }
    end
  end

  # GET /languages/1/alternations/1
  # GET /languages/1/alternations/1.json
  def show
    @alternation = @language.alternations.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alternation }
    end
  end

end
