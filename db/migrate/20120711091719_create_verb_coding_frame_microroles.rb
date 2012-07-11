class CreateVerbCodingFrameMicroroles < ActiveRecord::Migration
  def change
    create_table :verb_coding_frame_microroles, id: false do |t|
      t.references :microrole
      t.references :verb
      t.references :coding_frame

    end
    add_index :verb_coding_frame_microroles, :microrole_id,    name: 'index_vcfmr_mr_id'
    add_index :verb_coding_frame_microroles, :verb_id,         name: 'index_vcfmr_verb_id'   
    add_index :verb_coding_frame_microroles, :coding_frame_id, name: 'index_vcfmr_cf_id'
  end
end
