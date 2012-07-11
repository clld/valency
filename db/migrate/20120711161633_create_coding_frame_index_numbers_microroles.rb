class CreateCodingFrameIndexNumbersMicroroles < ActiveRecord::Migration
  def change
    create_table :coding_frame_index_numbers_microroles, id:false do |t|
      t.references :coding_frame_index_number
      t.references :microrole
    end
    
    add_index :coding_frame_index_numbers_microroles, [:coding_frame_index_number_id, :microrole_id], name:'uniq_idx_cfinmr_on_cfin_id_and_mr_id'
  end
end
