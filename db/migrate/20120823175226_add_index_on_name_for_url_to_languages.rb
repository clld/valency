class AddIndexOnNameForUrlToLanguages < ActiveRecord::Migration
  def change
    add_index "languages", ["name_for_url"], :name => "index_languages_on_name_for_url", :unique => true
  end
end
