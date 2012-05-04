class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.integer :id
      t.references :language
      t.references :person
      t.integer :sort_order_number

      t.timestamps
    end
    add_index :contributions, :id, :unique => true
    add_index :contributions, :language_id
    add_index :contributions, :person_id
  end
end
