class VerbsController < ApplicationController
  # GET /verbs
  # GET /verbs.json
  def index
    @verbs = Verb.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @verbs }
    end
  end

  # GET /verbs/1
  # GET /verbs/1.json
  def show
    @verb = Verb.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @verb }
    end
  end

  # GET /verbs/new
  # GET /verbs/new.json
  def new
    @verb = Verb.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @verb }
    end
  end

  # GET /verbs/1/edit
  def edit
    @verb = Verb.find(params[:id])
  end

  # POST /verbs
  # POST /verbs.json
  def create
    @verb = Verb.new(params[:verb])

    respond_to do |format|
      if @verb.save
        format.html { redirect_to @verb, notice: 'Verb was successfully created.' }
        format.json { render json: @verb, status: :created, location: @verb }
      else
        format.html { render action: "new" }
        format.json { render json: @verb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /verbs/1
  # PUT /verbs/1.json
  def update
    @verb = Verb.find(params[:id])

    respond_to do |format|
      if @verb.update_attributes(params[:verb])
        format.html { redirect_to @verb, notice: 'Verb was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @verb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /verbs/1
  # DELETE /verbs/1.json
  def destroy
    @verb = Verb.find(params[:id])
    @verb.destroy

    respond_to do |format|
      format.html { redirect_to verbs_url }
      format.json { head :no_content }
    end
  end
end
