class CreateCodingFrameExamples < ActiveRecord::Migration
  def change
    create_table :coding_frame_examples, id: false do |t|
      t.references :example
      t.references :verb
      t.references :coding_frame

    end
    add_index :coding_frame_examples, :verb_id
    add_index :coding_frame_examples, :coding_frame_id
    add_index :coding_frame_examples, :example_id
  end
end
