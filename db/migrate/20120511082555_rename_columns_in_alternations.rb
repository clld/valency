class RenameColumnsInAlternations < ActiveRecord::Migration
  def change
    rename_column :alternations, :alternation_name,             :name
    rename_column :alternations, :alternation_type,             :type
    rename_column :alternations, :coding_frames_of_alternation, :coding_frames_text    
  end
end
