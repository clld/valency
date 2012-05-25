class CreateGlossMeanings < ActiveRecord::Migration
  def change
    create_table :gloss_meanings do |t|
      t.integer :id
      t.references :language
      t.string :gloss
      t.string :meaning
      t.text :comment

    end
    add_index :gloss_meanings, :language_id
    add_index :gloss_meanings, :gloss
  end
end
