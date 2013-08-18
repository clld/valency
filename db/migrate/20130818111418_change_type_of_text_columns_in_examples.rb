class ChangeTypeOfTextColumnsInExamples < ActiveRecord::Migration

  # :string type is VARCHAR(255) and won't allow longer values
  def up
   change_column :examples, :translation,          :text
   change_column :examples, :translation_other,    :text
   change_column :examples, :original_orthography, :text 
  end

  def down
    # this will cause trouble if there is content longer than 255 characters
    change_column :examples, :translation,          :string
    change_column :examples, :translation_other,    :string
    change_column :examples, :original_orthography, :string 
  end
end
