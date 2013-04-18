# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Seed Users
user = User.create(
                   first_name: 'Joe',
                   last_name: 'Admin',
                   email: 'admin@admin.asdf',
                   role: 'admin',
                   password: "AdminFF",
                   password_confirmation: "AdminFF",
                   )
user.confirm!

user = User.create(
                   first_name: 'Joe',
                   last_name: 'Buyer',
                   email: 'buyer@buyer.asdf',
                   role: 'buyer',
                   password: "BuyerFF",
                   password_confirmation: "BuyerFF",
                   )
user.confirm!
p = BuyerProfile.create(
                   name: "Williams College",
                   street_address_1: "355 Auburn St",
                   city: "Boulder",
                   state: "CO",
                   zip: "80305",
                   phone: "440-796-7082",
                   description: "I am a test buyer",
                   user_id: user.id
                   )

user = User.create(
                   first_name: 'Joe',
                   last_name: 'Producer',
                   email: 'producer@producer.asdf',
                   role: 'producer',
                   password: "ProducerFF",
                   password_confirmation: "ProducerFF",
                   )
user.confirm!
ProducerProfile.create(
                   name: "Bellview Farms",
                   street_address_1: "40 Harvard Rd",
                   city: "Boulder",
                   state: "CO",
                   zip: "80305",
                   phone: "440-796-7082",
                   description: "I am a test producer",
                   user_id: user.id
                   )

require File.expand_path('../seed_products', __FILE__)
require File.expand_path('../seed_product_pics', __FILE__)
require File.expand_path('../seed_certifications', __FILE__)
