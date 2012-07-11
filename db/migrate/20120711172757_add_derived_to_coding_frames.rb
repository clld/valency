class AddDerivedToCodingFrames < ActiveRecord::Migration
  def change
    add_column :coding_frames, :derived, :string
  end
end
