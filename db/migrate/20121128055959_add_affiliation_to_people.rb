class AddAffiliationToPeople < ActiveRecord::Migration
  def change
    add_column :people, :affiliation, :string
    add_column :people, :photo_url,   :string
    add_column :people, :email,       :string
  end
end
