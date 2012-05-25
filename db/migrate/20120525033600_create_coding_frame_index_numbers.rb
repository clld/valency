class CreateCodingFrameIndexNumbers < ActiveRecord::Migration
  def change
    create_table :coding_frame_index_numbers do |t|
      t.integer :id
      t.integer :index_number
      t.references :coding_set
      t.references :coding_frame
      t.references :argument_type

    end
    add_index :coding_frame_index_numbers, :coding_set_id
    add_index :coding_frame_index_numbers, :coding_frame_id
    add_index :coding_frame_index_numbers, :argument_type_id
  end
end
