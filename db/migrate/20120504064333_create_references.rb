class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.integer :id
      t.string :authors
      t.string :year
      t.string :year_disambiguation_letter
      t.string :article_title
      t.string :editors
      t.string :bibtex_type
      t.string :book_title
      t.string :city
      t.string :issue
      t.string :journal
      t.string :pages
      t.string :publisher
      t.string :series_title
      t.string :url
      t.string :volume
      t.string :latex_cite_key
      t.text :additional_information
      t.text :full_reference

      t.timestamps
    end
    add_index :references, :id, :unique => true
  end
end
