class AlternationsController < ApplicationController
  before_filter :get_language
  
  def get_language
    @language = Language.includes(:alternations, :gloss_meanings).find_by_name_for_url(params[:language_id])
    cookies[:current_language_id] = @language.id
    @gloss_abbr = @language.gloss_meanings_hash
    @contributors    = @language.get_contributors
  end
  
  # GET /languages/german/alternations[.json]
  def index
    @alternations = @language.alternations.includes(:alternation_values, :verbs).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alternations }
    end
  end

  # GET /languages/german/alternations/1[.json]
  def show
    @alternation = @language.alternations.includes(
      :alternation_values => [
        :examples,
        :derived_coding_frame,
        {:verb => [:meanings, :coding_frame]}
      ]
    ).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alternation }
    end
  end

end
