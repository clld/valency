class AddIdToCfinAddIndexes < ActiveRecord::Migration
  def change
    add_column :coding_frame_index_numbers, :id, :primary_key    

    rename_index :coding_frame_index_numbers, "index_argtype_id", "index_cfin_on_argtype_id"
    rename_index :coding_frame_index_numbers, "index_cf_id",      "index_cfin_on_cf_id"
    rename_index :coding_frame_index_numbers, "index_cs_id",      "index_cfin_on_cs_id"
    
    add_index :coding_frame_index_numbers, [:coding_frame_id, :index_number], unique:true, name:'uniq_idx_cfin_on_cf_id_and_in'

    add_index :alternation_values, [:verb_id, :alternation_id], unique:true, name:'uniq_idx_av_on_verb_id_and_altn_id'
    
  end
end
