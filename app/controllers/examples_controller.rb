class ExamplesController < ApplicationController
  before_filter :get_language
  before_filter :get_examples, only: :index
  
  def get_language
    @language   = Language.includes(:examples, :gloss_meanings).find_by_name_for_url(params[:language_id])
    cookies[:current_language_id] = @language.id
    @contributors    = @language.get_contributors
    @gloss_abbr = @language.gloss_meanings_hash
  end
  
  def get_examples
    @examples = @language.examples.includes(:verbs, :alternation_values, :coding_frames)
  end
  
  # GET /languages/1/examples
  # GET /languages/1/examples.json
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @examples }
    end
  end

  # GET /languages/1/examples/1
  # GET /languages/1/examples/1.json
  def show
    begin
      @example = Example.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      # last URL parameter is not example ID, but the example's number
      @example = @language.examples.where(number: params[:id].to_i).first
    end
    @examples = [@example]
    respond_to do |format|
      format.html { render 'examples/index' } # also show index.html.erb
      format.json { render json: @example   }
    end
  end

end
