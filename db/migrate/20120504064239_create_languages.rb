class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.integer :id
      t.string :name
      t.string :iso_code
      t.string :family
      t.string :variety

      t.timestamps
    end
    add_index :languages, :id, :unique => true
  end
end
