class MeaningsController < ApplicationController
  # GET /meanings
  # GET /meanings.json
  def index
    @meanings = Meaning.includes(:verbs, :microroles).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meanings }
    end
  end

  # GET /meanings/1
  # GET /meanings/1.json
  def show
    # TODO remove the bang in production
    @meaning = Meaning.find_by_label_for_url!(params[:id])
    @microroles = @meaning.microroles.all
    @verbs      = @meaning.verbs.includes(:coding_frame)
    @arg_counts = @verbs.map do |v|
      cf = v.coding_frame
      cf.arg_count unless cf.nil? || cf.coding_frame_schema.blank?
    end.uniq.delete_if{|x|x.nil?}.sort!

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meaning }
    end
  end

end
