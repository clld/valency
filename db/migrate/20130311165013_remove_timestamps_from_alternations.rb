class RemoveTimestampsFromAlternations < ActiveRecord::Migration
  # remove timestamps from every table except languages
  def change
    remove_timestamps :alternations
    remove_timestamps :coding_frames
    remove_timestamps :examples
    remove_timestamps :people
    remove_timestamps :meanings
    remove_timestamps :references
    remove_timestamps :verbs    
  end
end
