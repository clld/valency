class CreateCodingSets < ActiveRecord::Migration
  def change
    create_table :coding_sets do |t|
      t.integer :id
      t.references :language
      t.string :name
      t.text :comment

    end
    add_index :coding_sets, :language_id
  end
end
