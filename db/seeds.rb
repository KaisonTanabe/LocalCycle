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

require File.expand_path('../seed_products', __FILE__)
require File.expand_path('../seed_product_pics', __FILE__)
require File.expand_path('../alter_product_tree', __FILE__)
require File.expand_path('../seed_certifications', __FILE__)


b = User.create(
                   first_name: 'Joe',
                   last_name: 'Buyer',
                   email: 'buyer@buyer.asdf',
                   role: 'buyer',
                   password: "BuyerFF",
                   password_confirmation: "BuyerFF",
                   name: "Williams College",
                   street_address_1: "880 Main St",
                   city: "Williamstown",
                   state: "MA",
                   zip: "01267",
                   phone: "440-555-5555",
                   description: "Williams College is a private liberal arts college located in Williamstown, Massachusetts, United States. It was established in 1793 with funds from the estate of Ephraim Williams. Originally a men's college, Williams became co-educational in 1970.",
                   complete: true,
                   )
b.confirm!

p = User.create(
                   first_name: 'Joe',
                   last_name: 'Producer',
                   email: 'producer@producer.asdf',
                   role: 'producer',
                   password: "ProducerFF",
                   password_confirmation: "ProducerFF",
                   name: "Bellview Farms",
                   street_address_1: "51 Walden St",
                   city: "Williamstown",
                   state: "MA",
                   zip: "01267",
                   phone: "440-796-7082",
                   description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque convallis consectetur. Morbi quam sem, vestibulum quis tristique eget, tempor quis nisl. Duis at erat id eros vehicula cursus.",
                   growing_methods: GROWING_METHODS.key("Organic"),
                   has_eggs: true,
                   size: 0,
                   certification_ids: Certification.where(name: ["HCAAP"]).map{|c| c.id},
                   complete: true,
                   )
p.confirm!

a = Agreement.create(
                 creator_id: b.id,
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
                       user_id: b.id,
                       agreement_id: a.id,
                       price: 3.00,
                       quantity: 100,
                       frequency: "weekly",
                       transport_by: "producer",
                       transport_instructions: "Producer will deliver (pick one)\nTuesdays 3pm-5pm\nThursdays 3pm-5pm\nSaturdays 10am-2pm\nAddress: 480 Spring Street, Williamstown, MA, 01267",
                       agree: false
)
AgreementChange.create(
                       user_id: p.id,
                       agreement_id: a.id,
                       price: 3.50,
                       quantity: 80,
                       transport_instructions: "Producer will deliver Tuesdays 3pm-5pm\nAddress: 480 Spring Street, Williamstown, MA, 01267",
                       reason: "I can supply you with 80lbs at $3.50/lb.",
                       agree: false
)
AgreementChange.create(
                       user_id: b.id,
                       agreement_id: a.id,
                       price: 3.29,
                       reason: "We'd be willing to do $3.29/lb.",
                       agree: false
)
AgreementChange.create(
                       user_id: p.id,
                       agreement_id: a.id,
                       agree: true
)
AgreementChange.create(
                       user_id: b.id,
                       agreement_id: a.id,
                       agree: true
)
