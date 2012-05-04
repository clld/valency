class CreateAlternations < ActiveRecord::Migration
  def change
    create_table :alternations do |t|
      t.integer :id
      t.references :language
      t.string :alternation_name
      t.string :alternation_type
      t.string :coding_frames_of_alternation
      t.text :description

      t.timestamps
    end
    add_index :alternations, :id, :unique => true
    add_index :alternations, :language_id
  end
end
