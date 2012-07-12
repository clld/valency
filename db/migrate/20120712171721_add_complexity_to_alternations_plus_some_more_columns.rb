class AddComplexityToAlternationsPlusSomeMoreColumns < ActiveRecord::Migration
  def change
    add_column :alternations, :complexity, :string
    
    add_column :argument_types, :comment, :text
    
    add_column :examples, :type, :string
    add_column :examples, :number, :integer
  end
end
