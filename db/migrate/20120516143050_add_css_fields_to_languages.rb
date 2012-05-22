class AddCssFieldsToLanguages < ActiveRecord::Migration
  def change
    add_column :languages, :alternation_occurs_judgement_criteria, :text
    add_column :languages, :characterization_of_flagging_resources, :text
    add_column :languages, :characterization_of_indexing_resources, :text
    add_column :languages, :characterization_of_ordering_resources, :text
    add_column :languages, :comments, :text
    add_column :languages, :data_sources_generalizations_contributor_backgrounds, :text
  end
end
