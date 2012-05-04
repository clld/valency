class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :id
      t.string :name
      t.string :contributor
      t.string :native_speaker
      t.string :url

      t.timestamps
    end
    add_index :people, :id, :unique => true
  end
end
