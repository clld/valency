class DropJoinTables < ActiveRecord::Migration
  def up
    drop_table :examples_verbs
    drop_table :meanings_verbs
    drop_table :alternation_values_examples
  end

  def down
    # no rollback functionality! This migration is irreversible
  end
end
