class AddIndexOnIdToMicrorolesAndAddIndexesToAlternationValues < ActiveRecord::Migration
  def change
  add_index "microroles", ["id"], :name => "index_microroles_on_id", :unique => true

  add_index "alternation_values", ["derived_coding_frame_id"], :name => "index_altn_values_on_derived_cf_id"
  
  rename_index "alternation_values", "index_alternation_values_on_alternation_id", "index_altn_values_on_altn_id"
  rename_index "alternation_values", "uniq_idx_av_on_verb_id_and_altn_id", "uniq_idx_altn_values_on_verb_id_and_altn_id"
  rename_index "alternation_values", "index_alternation_values_on_verb_id", "index_altn_values_on_verb_id"
  
  end
end
