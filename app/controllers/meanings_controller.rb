class MeaningsController < ApplicationController
  # GET /meanings
  # GET /meanings.json
  def index
    @meanings = Meaning.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meanings }
    end
  end

  # GET /meanings/1
  # GET /meanings/1.json
  def show
    @meaning = Meaning.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meaning }
    end
  end

end
