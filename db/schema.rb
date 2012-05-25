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

ActiveRecord::Schema.define(:version => 20120525045841) do

  create_table "alternation_values", :force => true do |t|
    t.integer "verb_id"
    t.integer "alternation_id"
    t.string  "alternation_occurs"
    t.text    "alternation_comment"
  end

  add_index "alternation_values", ["alternation_id"], :name => "index_alternation_values_on_alternation_id"
  add_index "alternation_values", ["verb_id"], :name => "index_alternation_values_on_verb_id"

  create_table "alternation_values_examples", :id => false, :force => true do |t|
    t.integer "alternation_value_id"
    t.integer "example_id"
  end

  add_index "alternation_values_examples", ["alternation_value_id"], :name => "index_alternation_values_examples_on_alternation_value_id"
  add_index "alternation_values_examples", ["example_id"], :name => "index_alternation_values_examples_on_example_id"

  create_table "alternations", :force => true do |t|
    t.integer  "language_id"
    t.string   "name"
    t.string   "type"
    t.string   "coding_frames_text"
    t.text     "description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "alternations", ["id"], :name => "index_alternations_on_id", :unique => true
  add_index "alternations", ["language_id"], :name => "index_alternations_on_language_id"

  create_table "argument_types", :force => true do |t|
    t.string "argument_type"
    t.text   "description"
  end

  create_table "coding_frame_examples", :id => false, :force => true do |t|
    t.integer "example_id"
    t.integer "verb_id"
    t.integer "coding_frame_id"
  end

  add_index "coding_frame_examples", ["coding_frame_id"], :name => "index_coding_frame_examples_on_coding_frame_id"
  add_index "coding_frame_examples", ["example_id"], :name => "index_coding_frame_examples_on_example_id"
  add_index "coding_frame_examples", ["verb_id"], :name => "index_coding_frame_examples_on_verb_id"

  create_table "coding_frame_index_numbers", :force => true do |t|
    t.integer "index_number"
    t.integer "coding_set_id"
    t.integer "coding_frame_id"
    t.integer "argument_type_id"
  end

  add_index "coding_frame_index_numbers", ["argument_type_id"], :name => "index_coding_frame_index_numbers_on_argument_type_id"
  add_index "coding_frame_index_numbers", ["coding_frame_id"], :name => "index_coding_frame_index_numbers_on_coding_frame_id"
  add_index "coding_frame_index_numbers", ["coding_set_id"], :name => "index_coding_frame_index_numbers_on_coding_set_id"

  create_table "coding_frames", :force => true do |t|
    t.integer  "language_id"
    t.string   "coding_frame_schema"
    t.text     "description"
    t.text     "comment"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "coding_frames", ["id"], :name => "index_coding_frames_on_id", :unique => true
  add_index "coding_frames", ["language_id"], :name => "index_coding_frames_on_language_id"

  create_table "coding_sets", :force => true do |t|
    t.integer "language_id"
    t.string  "name"
    t.text    "comment"
  end

  add_index "coding_sets", ["language_id"], :name => "index_coding_sets_on_language_id"

  create_table "contributions", :force => true do |t|
    t.integer "language_id"
    t.integer "person_id"
    t.integer "sort_order_number"
  end

  add_index "contributions", ["id"], :name => "index_contributions_on_id", :unique => true
  add_index "contributions", ["language_id"], :name => "index_contributions_on_language_id"
  add_index "contributions", ["person_id"], :name => "index_contributions_on_person_id"

  create_table "examples", :force => true do |t|
    t.integer  "language_id"
    t.integer  "reference_id"
    t.integer  "person_id"
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
  end

  add_index "examples", ["id"], :name => "index_examples_on_id", :unique => true
  add_index "examples", ["language_id"], :name => "index_examples_on_language_id"
  add_index "examples", ["person_id"], :name => "index_examples_on_person_id"
  add_index "examples", ["reference_id"], :name => "index_examples_on_reference_id"

  create_table "examples_verbs", :id => false, :force => true do |t|
    t.integer "example_id"
    t.integer "verb_id"
  end

  add_index "examples_verbs", ["example_id"], :name => "index_examples_verbs_on_example_id"
  add_index "examples_verbs", ["verb_id"], :name => "index_examples_verbs_on_verb_id"

  create_table "gloss_meanings", :force => true do |t|
    t.integer "language_id"
    t.string  "gloss"
    t.string  "meaning"
    t.text    "comment"
  end

  add_index "gloss_meanings", ["gloss"], :name => "index_gloss_meanings_on_gloss"
  add_index "gloss_meanings", ["language_id"], :name => "index_gloss_meanings_on_language_id"

  create_table "languages", :force => true do |t|
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

  create_table "meanings", :force => true do |t|
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
    t.integer "meaning_id"
    t.integer "verb_id"
  end

  add_index "meanings_verbs", ["meaning_id"], :name => "index_meanings_verbs_on_meaning_id"
  add_index "meanings_verbs", ["verb_id"], :name => "index_meanings_verbs_on_verb_id"

  create_table "microroles", :force => true do |t|
    t.string  "name"
    t.integer "meaning_id"
    t.string  "role_letter"
    t.string  "original_or_new"
  end

  add_index "microroles", ["meaning_id"], :name => "index_microroles_on_meaning_id"

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "contributor"
    t.string   "native_speaker"
    t.string   "url"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "people", ["id"], :name => "index_people_on_id", :unique => true

  create_table "references", :force => true do |t|
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

  create_table "verbs", :force => true do |t|
    t.integer  "language_id"
    t.integer  "coding_frame_id"
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
