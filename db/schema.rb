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

ActiveRecord::Schema.define(:version => 20130418165915) do

  create_table "agreements", :force => true do |t|
    t.integer  "product_id",                                      :null => false
    t.integer  "buyer_id"
    t.integer  "producer_id"
    t.string   "name",                                            :null => false
    t.text     "description"
    t.string   "agreement_type",                                  :null => false
    t.string   "frequency"
    t.date     "start_date",            :default => '2013-04-23', :null => false
    t.date     "end_date"
    t.float    "quantity",                                        :null => false
    t.string   "selling_unit",                                    :null => false
    t.float    "price",                                           :null => false
    t.boolean  "locally_packaged",      :default => false,        :null => false
    t.boolean  "can_deliver",           :default => false,        :null => false
    t.text     "delivery_options"
    t.float    "min_delivery_quantity"
    t.float    "delivery_fee"
    t.boolean  "can_pickup",            :default => false,        :null => false
    t.text     "pickup_options"
    t.float    "min_pickup_quantity"
    t.float    "max_pickup_quantity"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

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

  create_table "buyer_agreements", :force => true do |t|
    t.integer  "user_id"
    t.integer  "agreement_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "buyer_agreements", ["agreement_id"], :name => "index_buyer_agreements_on_agreement_id"
  add_index "buyer_agreements", ["user_id"], :name => "index_buyer_agreements_on_user_id"

  create_table "buyer_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",                               :null => false
    t.string   "street_address_1",                   :null => false
    t.string   "street_address_2"
    t.string   "city",                               :null => false
    t.string   "state",                              :null => false
    t.string   "country",          :default => "US", :null => false
    t.string   "zip",                                :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "phone"
    t.text     "description"
    t.string   "website"
    t.string   "twitter"
    t.string   "facebook"
    t.boolean  "text_updates",     :default => true, :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  add_index "buyer_profiles", ["user_id"], :name => "index_buyer_profiles_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.integer  "fakeid"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"

  create_table "category_hierarchies", :id => false, :force => true do |t|
    t.integer "ancestor_id",   :null => false
    t.integer "descendant_id", :null => false
    t.integer "generations",   :null => false
  end

  add_index "category_hierarchies", ["ancestor_id", "descendant_id"], :name => "index_category_hierarchies_on_ancestor_id_and_descendant_id", :unique => true
  add_index "category_hierarchies", ["descendant_id"], :name => "index_category_hierarchies_on_descendant_id"

  create_table "certifications", :force => true do |t|
    t.string   "name",                               :null => false
    t.string   "cert_type",  :default => "producer", :null => false
    t.boolean  "audited",    :default => false,      :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "certifications_producer_profiles", :force => true do |t|
    t.integer "certification_id",    :null => false
    t.integer "producer_profile_id", :null => false
  end

  add_index "certifications_producer_profiles", ["certification_id"], :name => "index_certifications_producer_profiles_on_certification_id"
  add_index "certifications_producer_profiles", ["producer_profile_id"], :name => "index_certifications_producer_profiles_on_producer_profile_id"

  create_table "images", :force => true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "images", ["imageable_id", "imageable_type"], :name => "index_images_on_imageable_id_and_imageable_type"

  create_table "leads", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "producer_agreements", :force => true do |t|
    t.integer  "user_id"
    t.integer  "agreement_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "producer_agreements", ["agreement_id"], :name => "index_producer_agreements_on_agreement_id"
  add_index "producer_agreements", ["user_id"], :name => "index_producer_agreements_on_user_id"

  create_table "producer_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",                                       :null => false
    t.string   "street_address_1",                           :null => false
    t.string   "street_address_2"
    t.string   "city",                                       :null => false
    t.string   "state",                                      :null => false
    t.string   "country",                :default => "US",   :null => false
    t.string   "zip",                                        :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "phone"
    t.text     "description"
    t.string   "website"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "growing_methods",        :default => "none", :null => false
    t.text     "custom_growing_methods"
    t.boolean  "has_eggs",               :default => false,  :null => false
    t.boolean  "has_livestock",          :default => false,  :null => false
    t.boolean  "has_dairy",              :default => false,  :null => false
    t.boolean  "has_pantry",             :default => false,  :null => false
    t.boolean  "text_updates",           :default => true,   :null => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  add_index "producer_profiles", ["user_id"], :name => "index_producer_profiles_on_user_id"

  create_table "products", :force => true do |t|
    t.string   "name",                               :null => false
    t.integer  "category_id",                        :null => false
    t.text     "description"
    t.string   "unit_type",        :default => "lb", :null => false
    t.float    "catch_weight",     :default => 0.0,  :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  add_index "products", ["category_id"], :name => "index_products_on_category_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name",                             :null => false
    t.string   "last_name",                              :null => false
    t.string   "role",                                   :null => false
    t.text     "notes"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
