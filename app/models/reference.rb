class Reference < ActiveRecord::Base
  self.primary_key = :id
  # attr_accessible :additional_information, :article_title, :authors, :bibtex_type, :book_title, :city, :editors, :full_reference, :id, :issue, :journal, :latex_cite_key, :pages, :publisher, :series_title, :url, :volume, :year, :year_disambiguation_letter

  has_many :examples
  
end
