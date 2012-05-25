class RecreateJoinTables < ActiveRecord::Migration
  def change
    create_table :examples_verbs, id: false do |t|
      t.references :example
      t.references :verb
    end
    add_index :examples_verbs, :example_id
    add_index :examples_verbs, :verb_id
    
    create_table :meanings_verbs, id: false do |t|
      t.references :meaning
      t.references :verb
    end
    add_index :meanings_verbs, :meaning_id
    add_index :meanings_verbs, :verb_id
    
    create_table :alternation_values_examples, id: false do |t|
      t.references :alternation_value
      t.references :example
    end
    add_index :alternation_values_examples, :alternation_value_id
    add_index :alternation_values_examples, :example_id
  end
end