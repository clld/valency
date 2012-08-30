class AddLabelForUrlToMeanings < ActiveRecord::Migration
  def change
    add_column :meanings,   :label_for_url, :string
    add_column :microroles, :name_for_url,  :string
    
  end
end
