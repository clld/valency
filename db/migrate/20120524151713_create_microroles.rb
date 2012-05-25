class CreateMicroroles < ActiveRecord::Migration
  def change
    create_table :microroles do |t|
      t.integer :id
      t.string :name
      t.references :meaning
      t.string :role_letter
      t.string :original_or_new

    end
    add_index :microroles, :meaning_id
  end
end
