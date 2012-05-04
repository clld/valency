class CreateMeanings < ActiveRecord::Migration
  def change
    create_table :meanings do |t|
      t.integer :id
      t.integer :number
      t.string :label
      t.string :role_frame
      t.string :typical_context
      t.string :meaning_list

      t.timestamps
    end
    add_index :meanings, :id, :unique => true
  end
end
