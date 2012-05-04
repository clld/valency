class CreateExamplesVerbs < ActiveRecord::Migration
  def change
    create_table :examples_verbs do |t|
      t.references :example
      t.references :verb

      t.timestamps
    end
    add_index :examples_verbs, :example_id
    add_index :examples_verbs, :verb_id
  end
end
