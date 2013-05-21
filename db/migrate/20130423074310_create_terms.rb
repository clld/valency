class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :term
      t.string :description
      t.text   :definition
      t.string :see_also
    end
  end
end
