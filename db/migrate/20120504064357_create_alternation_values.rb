class CreateAlternationValues < ActiveRecord::Migration
  def change
    create_table :alternation_values do |t|
      t.references :verb
      t.references :alternation
      t.string :alternation_occurs
      t.text :alternation_comment

      t.timestamps
    end
    add_index :alternation_values, :verb_id
    add_index :alternation_values, :alternation_id
  end
end
