# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120713031209) do

  create_table "alternation_values", :force => true, :id => false do |t|
    t.column "verb_id", 'BIGINT'
    t.column "id", 'BIGINT'
    t.column "alternation_id", 'BIGINT'
    t.string  "alternation_occurs"
    t.text    "alternation_comment"
    t.column "derived_coding_frame_id", 'BIGINT'
  end

  add_index "alternation_values", ["alternation_id"], :name => "index_alternation_values_on_alternation_id"
  add_index "alternation_values", ["verb_id", "alternation_id"], :name => "uniq_idx_av_on_verb_id_and_altn_id", :unique => true
  add_index "alternation_values", ["verb_id"], :name => "index_alternation_values_on_verb_id"

  create_table "alternation_values_examples", :id => false, :force => true do |t|
    t.column "alternation_value_id", 'BIGINT'
    t.column "example_id", 'BIGINT'
  end

  add_index "alternation_values_examples", ["alternation_value_id"], :name => "index_alternation_values_examples_on_alternation_value_id"
  add_index "alternation_values_examples", ["example_id"], :name => "index_alternation_values_examples_on_example_id"

  create_table "alternations", :force => true, :id => false do |t|
    t.column "id", 'BIGINT'
    t.column "language_id", 'BIGINT'
    t.string   "name"
    t.string   "type"
    t.string   "coding_frames_text"
    t.text     "description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "complexity"
  end

  add_index "alternations", ["id"], :name => "index_alternations_on_id", :unique => true
  add_index "alternations", ["language_id"], :name => "index_alternations_on_language_id"

  create_table "argument_types", :force => true, :id => false do |t|
    t.column "id", 'BIGINT'
    t.string "argument_type"
    t.text   "description"
    t.text   "comment"
  end

  create_table "coding_frame_examples", :id => false, :force => true do |t|
    t.column "example_id", 'BIGINT'
    t.column "verb_id", 'BIGINT'
    t.column "coding_frame_id", 'BIGINT'
  end

  add_index "coding_frame_examples", ["coding_frame_id"], :name => "index_coding_frame_examples_on_coding_frame_id"
  add_index "coding_frame_examples", ["example_id"], :name => "index_coding_frame_examples_on_example_id"
  add_index "coding_frame_examples", ["verb_id"], :name => "index_coding_frame_examples_on_verb_id"

  create_table "coding_frame_index_numbers", :force => true, :id => false do |t|
    t.column "id", 'BIGINT'
    t.integer "index_number"
    t.column "coding_set_id", 'BIGINT'
    t.column "coding_frame_id", 'BIGINT'
    t.column "argument_type_id", 'BIGINT'
  end

  add_index "coding_frame_index_numbers", ["argument_type_id"], :name => "index_cfin_on_argtype_id"
  add_index "coding_frame_index_numbers", ["coding_frame_id", "index_number"], :name => "uniq_idx_cfin_on_cf_id_and_in", :unique => true
  add_index "coding_frame_index_numbers", ["coding_frame_id"], :name => "index_cfin_on_cf_id"
  add_index "coding_frame_index_numbers", ["coding_set_id"], :name => "index_cfin_on_cs_id"

  create_table "coding_frame_index_numbers_microroles", :id => false, :force => true do |t|
    t.column "coding_frame_index_number_id", 'BIGINT'
    t.column "microrole_id", 'BIGINT'
  end

  add_index "coding_frame_index_numbers_microroles", ["coding_frame_index_number_id", "microrole_id"], :name => "uniq_idx_cfinmr_on_cfin_id_and_mr_id"

  create_table "coding_frames", :force => true, :id => false do |t|
    t.column "id", 'BIGINT'
    t.column "language_id", 'BIGINT'
    t.string   "coding_frame_schema"
    t.text     "description"
    t.text     "comment"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "derived"
  end

  add_index "coding_frames", ["id"], :name => "index_coding_frames_on_id", :unique => true
  add_index "coding_frames", ["language_id"], :name => "index_coding_frames_on_language_id"

  create_table "coding_sets", :force => true, :id => false do |t|
    t.column "id", 'BIGINT'
    t.column "language_id", 'BIGINT'
    t.string  "name"
    t.text    "comment"
  end

  add_index "coding_sets", ["language_id"], :name => "index_coding_sets_on_language_id"

  create_table "contributions", :id => false, :force => true do |t|
    t.column "language_id", 'BIGINT'
    t.column "person_id", 'BIGINT'
    t.integer "sort_order_number"
  end

  add_index "contributions", ["language_id"], :name => "index_contributions_on_language_id"
  add_index "contributions", ["person_id"], :name => "index_contributions_on_person_id"

  create_table "examples", :force => true, :id => false do |t|
    t.column "id", 'BIGINT'
    t.column "language_id", 'BIGINT'
    t.column "reference_id", 'BIGINT'
    t.column "person_id", 'BIGINT'
    t.string   "primary_text"
    t.string   "original_orthography"
    t.string   "analyzed_text"
    t.string   "gloss"
    t.string   "translation"
    t.string   "translation_other"
    t.text     "comment"
    t.string   "media_file_name"
    t.string   "media_file_timecode"
    t.string   "reference_pages"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "type"
    t.integer  "number"
  end

  add_index "examples", ["id"], :name => "index_examples_on_id", :unique => true
  add_index "examples", ["language_id"], :name => "index_examples_on_language_id"
  add_index "examples", ["person_id"], :name => "index_examples_on_person_id"
  add_index "examples", ["reference_id"], :name => "index_examples_on_reference_id"

  create_table "examples_verbs", :id => false, :force => true do |t|
    t.column "example_id", 'BIGINT'
    t.column "verb_id", 'BIGINT'
  end

  add_index "examples_verbs", ["example_id"], :name => "index_examples_verbs_on_example_id"
  add_index "examples_verbs", ["verb_id"], :name => "index_examples_verbs_on_verb_id"

  create_table "gloss_meanings", :force => true, :id => false do |t|
    t.column "id", 'BIGINT'
    t.column "language_id", 'BIGINT'
    t.string  "gloss"
    t.string  "meaning"
    t.text    "comment"
  end

  add_index "gloss_meanings", ["gloss"], :name => "index_gloss_meanings_on_gloss"
  add_index "gloss_meanings", ["language_id"], :name => "index_gloss_meanings_on_language_id"

  create_table "languages", :force => true, :id => false do |t|
    t.column "id", 'BIGINT'
    t.string   "name"
    t.string   "iso_code"
    t.string   "family"
    t.string   "variety"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.text     "alternation_occurs_judgement_criteria"
    t.text     "characterization_of_flagging_resources"
    t.text     "characterization_of_indexing_resources"
    t.text     "characterization_of_ordering_resources"
    t.text     "comments"
    t.text     "data_sources_generalizations_contributor_backgrounds"
  end

  add_index "languages", ["id"], :name => "index_languages_on_id", :unique => true

  create_table "meanings", :force => true, :id => false do |t|
    t.column "id", 'BIGINT'
    t.integer  "number"
    t.string   "label"
    t.string   "role_frame"
    t.string   "typical_context"
    t.string   "meaning_list"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "meanings", ["id"], :name => "index_meanings_on_id", :unique => true

  create_table "meanings_verbs", :id => false, :force => true do |t|
    t.column "meaning_id", 'BIGINT'
    t.column "verb_id", 'BIGINT'
  end

  add_index "meanings_verbs", ["meaning_id"], :name => "index_meanings_verbs_on_meaning_id"
  add_index "meanings_verbs", ["verb_id"], :name => "index_meanings_verbs_on_verb_id"

  create_table "microroles", :force => true, :id => false do |t|
    t.column "id", 'BIGINT'
    t.string  "name"
    t.column "meaning_id", 'BIGINT'
    t.string  "role_letter"
    t.string  "original_or_new"
  end

  add_index "microroles", ["meaning_id"], :name => "index_microroles_on_meaning_id"

  create_table "people", :force => true, :id => false do |t|
    t.column "id", 'BIGINT'
    t.string   "name"
    t.string   "contributor"
    t.string   "native_speaker"
    t.string   "url"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "people", ["id"], :name => "index_people_on_id", :unique => true

  create_table "references", :force => true, :id => false do |t|
    t.column "id", 'BIGINT'
    t.string   "authors"
    t.string   "year"
    t.string   "year_disambiguation_letter"
    t.string   "article_title"
    t.string   "editors"
    t.string   "bibtex_type"
    t.string   "book_title"
    t.string   "city"
    t.string   "issue"
    t.string   "journal"
    t.string   "pages"
    t.string   "publisher"
    t.string   "series_title"
    t.string   "url"
    t.string   "volume"
    t.string   "latex_cite_key"
    t.text     "additional_information"
    t.text     "full_reference"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "references", ["id"], :name => "index_references_on_id", :unique => true

  create_table "verb_coding_frame_microroles", :id => false, :force => true do |t|
    t.column "microrole_id", 'BIGINT'
    t.column "verb_id", 'BIGINT'
    t.column "coding_frame_id", 'BIGINT'
  end

  add_index "verb_coding_frame_microroles", ["coding_frame_id"], :name => "index_vcfmr_cf_id"
  add_index "verb_coding_frame_microroles", ["microrole_id"], :name => "index_vcfmr_mr_id"
  add_index "verb_coding_frame_microroles", ["verb_id"], :name => "index_vcfmr_verb_id"

  create_table "verbs", :force => true, :id => false do |t|
    t.column "language_id", 'BIGINT'
    t.column "coding_frame_id", 'BIGINT'
    t.string   "verb_form"
    t.string   "original_script"
    t.text     "comment"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "verbs", ["coding_frame_id"], :name => "index_verbs_on_coding_frame_id"
  add_index "verbs", ["id"], :name => "index_verbs_on_id", :unique => true
  add_index "verbs", ["language_id"], :name => "index_verbs_on_language_id"

end
