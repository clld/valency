class AlternationsController < ApplicationController
  # GET /alternations
  # GET /alternations.json
  def index
    @alternations = Alternation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alternations }
    end
  end

  # GET /alternations/1
  # GET /alternations/1.json
  def show
    @alternation = Alternation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alternation }
    end
  end

  # GET /alternations/new
  # GET /alternations/new.json
  def new
    @alternation = Alternation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alternation }
    end
  end

  # GET /alternations/1/edit
  def edit
    @alternation = Alternation.find(params[:id])
  end

  # POST /alternations
  # POST /alternations.json
  def create
    @alternation = Alternation.new(params[:alternation])

    respond_to do |format|
      if @alternation.save
        format.html { redirect_to @alternation, notice: 'Alternation was successfully created.' }
        format.json { render json: @alternation, status: :created, location: @alternation }
      else
        format.html { render action: "new" }
        format.json { render json: @alternation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alternations/1
  # PUT /alternations/1.json
  def update
    @alternation = Alternation.find(params[:id])

    respond_to do |format|
      if @alternation.update_attributes(params[:alternation])
        format.html { redirect_to @alternation, notice: 'Alternation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @alternation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alternations/1
  # DELETE /alternations/1.json
  def destroy
    @alternation = Alternation.find(params[:id])
    @alternation.destroy

    respond_to do |format|
      format.html { redirect_to alternations_url }
      format.json { head :no_content }
    end
  end
end
