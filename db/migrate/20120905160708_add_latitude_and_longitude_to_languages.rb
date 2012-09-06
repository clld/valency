class AddLatitudeAndLongitudeToLanguages < ActiveRecord::Migration
  def change
    add_column :languages, :latitude, :float
    add_column :languages, :longitude, :float
  end
end
