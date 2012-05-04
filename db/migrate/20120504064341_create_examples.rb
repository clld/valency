class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
      t.integer :id
      t.references :language
      t.references :reference
      t.references :person
      t.string :primary_text
      t.string :original_orthography
      t.string :analyzed_text
      t.string :gloss
      t.string :translation
      t.string :translation_other
      t.text :comment
      t.string :media_file_name
      t.string :media_file_timecode
      t.string :reference_pages

      t.timestamps
    end
    add_index :examples, :id, :unique => true
    add_index :examples, :language_id
    add_index :examples, :reference_id
    add_index :examples, :person_id
  end
end
