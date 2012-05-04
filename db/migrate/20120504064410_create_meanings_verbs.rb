class CreateMeaningsVerbs < ActiveRecord::Migration
  def change
    create_table :meanings_verbs do |t|
      t.references :meaning
      t.references :verb

      t.timestamps
    end
    add_index :meanings_verbs, :meaning_id
    add_index :meanings_verbs, :verb_id
  end
end
