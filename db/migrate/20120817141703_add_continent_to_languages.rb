class AddContinentToLanguages < ActiveRecord::Migration
  def change
    add_column :languages, :continent, :string
    add_column :languages, :name_for_url, :string
  end
end
