class CreateAlternationValuesExamples < ActiveRecord::Migration
  def change
    create_table :alternation_values_examples do |t|
      t.references :alternation
      t.references :example

      t.timestamps
    end
    add_index :alternation_values_examples, :alternation_id
    add_index :alternation_values_examples, :example_id
  end
end
