class AddSimplexOrComplexToVerbs < ActiveRecord::Migration
  def change
    add_column :verbs, :simplex_or_complex, :string
  end
end
