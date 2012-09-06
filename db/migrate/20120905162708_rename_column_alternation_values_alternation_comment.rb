class RenameColumnAlternationValuesAlternationComment < ActiveRecord::Migration
  def change
    rename_column :alternation_values, :alternation_comment, :comment
  end

end
