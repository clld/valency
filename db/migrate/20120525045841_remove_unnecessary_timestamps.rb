class RemoveUnnecessaryTimestamps < ActiveRecord::Migration
  def change
    change_table :alternation_values do |t|
      t.remove_timestamps
    end

    change_table :contributions do |t|
      t.remove_timestamps
    end

  end
end
