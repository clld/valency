class AddIndexesToCodingFrameIndexNumber < ActiveRecord::Migration
  def change
    add_index "coding_frame_index_numbers", ["id"], :name => "index_cfin_on_id", :unique => true
    add_index "coding_sets", ["id"], :name => "index_coding_sets_on_id", :unique => true
  end
end
