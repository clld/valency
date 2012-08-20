class ExamplesController < ApplicationController
  before_filter :get_language
  
  def get_language
    @language = Language.includes(:examples).find(params[:language_id])
  end
  
  # GET /languages/1/examples
  # GET /languages/1/examples.json
  def index
    @examples = @language.examples

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @examples }
    end
  end

  # GET /languages/1/examples/1
  # GET /languages/1/examples/1.json
  def show
    @example = @language.examples.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @example }
    end
  end

end
