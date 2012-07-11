class AddDerivedCodingFrameIdToAlternationValues < ActiveRecord::Migration
  def change
    add_column :alternation_values, :derived_coding_frame_id, :integer
  end
end
