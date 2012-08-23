class ChangeExamplesRenameTypeExampleType < ActiveRecord::Migration
  def up
    rename_column :examples, :type, :example_type
  end

  def down
    rename_column :examples, :example_type, :type
  end
end
