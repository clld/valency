class RemoveUnnecessaryIdColumns < ActiveRecord::Migration
  def up #irreversible!
    remove_index  :contributions, :id
    remove_column :contributions, :id

    rename_index :coding_frame_index_numbers, "index_coding_frame_index_numbers_on_argument_type_id", "index_argtype_id"
    rename_index :coding_frame_index_numbers, "index_coding_frame_index_numbers_on_coding_frame_id", "index_cf_id"
    rename_index :coding_frame_index_numbers, "index_coding_frame_index_numbers_on_coding_set_id", "index_cs_id"
    
    remove_column :coding_frame_index_numbers, :id
  end

end
