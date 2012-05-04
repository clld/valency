class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs do |t|
      t.references :language
      t.integer :id
      t.references :coding_frame
      t.string :verb_form
      t.string :original_script
      t.text :comment

      t.timestamps
    end
    add_index :verbs, :language_id
    add_index :verbs, :id, :unique => true
    add_index :verbs, :coding_frame_id
  end
end
