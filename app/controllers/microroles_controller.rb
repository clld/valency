class MicrorolesController < ApplicationController
  # GET /microroles
  # GET /microroles.json
  def index
    @microroles = Microrole.includes(:verb_coding_frame_microroles).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @microroles }
    end
  end

  # GET /microroles/1
  # GET /microroles/1.json
  def show
    @microrole  = Microrole.find_by_name_for_url(params[:id])
    @meaning    = @microrole.meaning
    @verb_cf_mr = @microrole.verb_coding_frame_microroles.includes(
      :coding_frame => {:coding_frame_index_numbers => [:argument_type, :coding_set]},
      :verb => :language
    )

    @arg_counts = @verb_cf_mr.map do |entry|
      cf = entry.coding_frame
      cf.arg_count unless cf.nil? || cf.coding_frame_schema.blank?
    end
    @arg_counts.uniq!
    @arg_counts.keep_if{|x|x} # reject nil values
    @arg_counts.sort!
    
    mr_index_numbers = @microrole.coding_frame_index_numbers
    @index_number_for_cf = Hash[ @microrole.coding_frames.map do |cf|
      [cf, (cf.coding_frame_index_numbers & mr_index_numbers).uniq.first || nil]
    end ]
    
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @microrole }
    end
  end

end
