class AddVerbCountToMicroroles < ActiveRecord::Migration
  def change
    add_column :microroles, :verbs_count,         :integer
    add_column :microroles, :coding_frames_count, :integer
    add_column :microroles, :languages_count,     :integer
  end
end
