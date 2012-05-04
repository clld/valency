class CodingFramesController < ApplicationController
  # GET /coding_frames
  # GET /coding_frames.json
  def index
    @coding_frames = CodingFrame.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coding_frames }
    end
  end

  # GET /coding_frames/1
  # GET /coding_frames/1.json
  def show
    @coding_frame = CodingFrame.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coding_frame }
    end
  end

  # GET /coding_frames/new
  # GET /coding_frames/new.json
  def new
    @coding_frame = CodingFrame.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coding_frame }
    end
  end

  # GET /coding_frames/1/edit
  def edit
    @coding_frame = CodingFrame.find(params[:id])
  end

  # POST /coding_frames
  # POST /coding_frames.json
  def create
    @coding_frame = CodingFrame.new(params[:coding_frame])

    respond_to do |format|
      if @coding_frame.save
        format.html { redirect_to @coding_frame, notice: 'Coding frame was successfully created.' }
        format.json { render json: @coding_frame, status: :created, location: @coding_frame }
      else
        format.html { render action: "new" }
        format.json { render json: @coding_frame.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /coding_frames/1
  # PUT /coding_frames/1.json
  def update
    @coding_frame = CodingFrame.find(params[:id])

    respond_to do |format|
      if @coding_frame.update_attributes(params[:coding_frame])
        format.html { redirect_to @coding_frame, notice: 'Coding frame was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coding_frame.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coding_frames/1
  # DELETE /coding_frames/1.json
  def destroy
    @coding_frame = CodingFrame.find(params[:id])
    @coding_frame.destroy

    respond_to do |format|
      format.html { redirect_to coding_frames_url }
      format.json { head :no_content }
    end
  end
end
