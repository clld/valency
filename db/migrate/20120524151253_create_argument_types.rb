class CreateArgumentTypes < ActiveRecord::Migration
  def change
    create_table :argument_types do |t|
      t.integer :id
      t.string :argument_type
      t.text :description

    end
  end
end
