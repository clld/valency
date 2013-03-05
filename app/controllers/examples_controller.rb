class ExamplesController < ApplicationController
  before_filter :get_language, :get_examples
  
  def get_language
    @language   = Language.includes(:examples, :gloss_meanings).find_by_name_for_url(params[:language_id])
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
    @example = @examples.find(params[:id])
    @examples = [@example]
    respond_to do |format|
      format.html { render 'examples/index' } # also show index.html.erb
      format.json { render json: @example   }
    end
  end

end
