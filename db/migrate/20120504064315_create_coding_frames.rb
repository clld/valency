class CreateCodingFrames < ActiveRecord::Migration
  def change
    create_table :coding_frames do |t|
      t.integer :id
      t.references :language
      t.string :coding_frame_schema
      t.text :description
      t.text :comment

      t.timestamps
    end
    add_index :coding_frames, :id, :unique => true
    add_index :coding_frames, :language_id
  end
end
