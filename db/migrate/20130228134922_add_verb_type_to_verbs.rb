class AddVerbTypeToVerbs < ActiveRecord::Migration
  def change
    add_column :verbs, :verb_type, :string
  end
end
