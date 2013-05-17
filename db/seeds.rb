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
b = BuyerProfile.create(
                   name: "Williams College",
                   street_address_1: "355 Auburn St",
                   city: "Boulder",
                   state: "CO",
                   zip: "80305",
                   phone: "440-796-7082",
                   description: "I am a test buyer",
                   user_id: user.id
                   )
#b.set_lat_long

user = User.create(
                   first_name: 'Joe',
                   last_name: 'Producer',
                   email: 'producer@producer.asdf',
                   role: 'producer',
                   password: "ProducerFF",
                   password_confirmation: "ProducerFF",
                   )
user.confirm!
p = ProducerProfile.create(
                   name: "Bellview Farms",
                   street_address_1: "3704 Telluride Cir",
                   city: "Boulder",
                   state: "CO",
                   zip: "80305",
                   phone: "440-796-7082",
                   description: "I am a test producer",
                   growing_methods: GROWING_METHODS.key("Organic"),
                   has_eggs: true,
                   user_id: user.id,
                   certification_ids: Certification.where(name: ["HCAAP"]),
                   )
#p.set_lat_long

require File.expand_path('../seed_products', __FILE__)
#require File.expand_path('../seed_product_pics', __FILE__)
require File.expand_path('../alter_product_tree', __FILE__)
require File.expand_path('../seed_certifications', __FILE__)

a = Agreement.create(
                 buyer_id: b.id,
                 producer_id: p.id,

                 product_id: Product.where(name: "Beet Greens").first.id,
                 name: "Organic Beet Greens",

                 price: 3.29,
                 quantity: 80,
                 selling_unit: "lb",

                 agreement_type: "indefinite",
                 frequency: "weekly",

                 transport_by: "producer",
                 transport_instructions: "Producer will deliver Tuesdays 3pm-5pm\nAddress: 480 Spring Street, Williamstown, MA, 01267"
)
AgreementChange.create(
                       buyer_id: b.id,
                       agreement_id: a.id,
                       price: 3.00,
                       quantity: 100,
                       frequency: "weekly",
                       transport_by: "producer",
                       transport_instructions: "Producer will deliver (pick one)\nTuesdays 3pm-5pm\nThursdays 3pm-5pm\nSaturdays 10am-2pm\nAddress: 480 Spring Street, Williamstown, MA, 01267",
                       agree: false
)
AgreementChange.create(
                       producer_id: p.id,
                       agreement_id: a.id,
                       price: 3.50,
                       quantity: 80,
                       transport_instructions: "Producer will deliver Tuesdays 3pm-5pm\nAddress: 480 Spring Street, Williamstown, MA, 01267",
                       reason: "I can supply you with 80lbs at $3.50/lb.",
                       agree: false
)
AgreementChange.create(
                       buyer_id: b.id,
                       agreement_id: a.id,
                       price: 3.29,
                       reason: "We'd be willing to do $3.29/lb.",
                       agree: false
)
AgreementChange.create(
                       producer_id: p.id,
                       agreement_id: a.id,
                       agree: true
)
AgreementChange.create(
                       buyer_id: b.id,
                       agreement_id: a.id,
                       agree: true
)
