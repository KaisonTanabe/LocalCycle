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

ActiveRecord::Schema.define(:version => 20130306051805) do

  create_table "attachments", :force => true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  add_index "attachments", ["attachable_id", "attachable_type"], :name => "index_attachments_on_attachable_id_and_attachable_type"

  create_table "form101as", :force => true do |t|
    t.integer  "form_id",                  :null => false
    t.string   "building"
    t.date     "expected_completion_date"
    t.string   "university"
    t.string   "course_title"
    t.string   "semester_hours"
    t.string   "sponsoring_organization"
    t.string   "workshop_title"
    t.string   "contact_hours"
    t.text     "anticipated_outcomes"
    t.text     "experience"
    t.string   "employee_signature"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "form101as", ["form_id"], :name => "index_form101as_on_form_id"

  create_table "form101bs", :force => true do |t|
    t.integer  "form_id",               :null => false
    t.boolean  "graded_coursework"
    t.boolean  "accredited_university"
    t.boolean  "syllabus"
    t.boolean  "approved_plan"
    t.boolean  "aligned_coursework"
    t.string   "course_application"
    t.text     "anticipated_outcomes"
    t.text     "experience_learned"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "form101bs", ["form_id"], :name => "index_form101bs_on_form_id"

  create_table "form_logs", :force => true do |t|
    t.string   "form_part",    :null => false
    t.string   "updater_name", :null => false
    t.text     "params",       :null => false
    t.integer  "form_id",      :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "form_reviews", :force => true do |t|
    t.integer  "form_id",                           :null => false
    t.integer  "user_id",                           :null => false
    t.string   "review",     :default => "pending", :null => false
    t.text     "reason"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "form_reviews", ["form_id"], :name => "index_form_reviews_on_form_id"
  add_index "form_reviews", ["user_id"], :name => "index_form_reviews_on_user_id"

  create_table "forms", :force => true do |t|
    t.string   "last_updater"
    t.text     "last_params"
    t.integer  "user_id",                          :null => false
    t.boolean  "seen",          :default => false, :null => false
    t.boolean  "approved",      :default => false, :null => false
    t.integer  "no_vote_count", :default => 999,   :null => false
    t.string   "form_type",                        :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "forms", ["user_id"], :name => "index_forms_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",         :null => false
    t.string   "encrypted_password",     :default => "",         :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "first_name",                                     :null => false
    t.string   "last_name",                                      :null => false
    t.string   "pin",                                            :null => false
    t.string   "role",                   :default => "educator", :null => false
    t.boolean  "active",                 :default => true,       :null => false
    t.string   "phone"
    t.text     "notes"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
