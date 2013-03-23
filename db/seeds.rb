# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Seed Users
user = User.create(
                   first_name: 'Macklin',
                   last_name: 'Chaffee',
                   email: 'admin@admin.asdf',
                   role: 'admin',
                   pin: 'asdf',
                   password: "AdminFF",
                   password_confirmation: "AdminFF",
                   )
user.confirm!
user = User.create(
                   first_name: 'Macklin',
                   last_name: 'Chaffee',
                   email: 'cm@cm.asdf',
                   role: 'cm',
                   pin: 'asdff',
                   password: "CmFF",
                   password_confirmation: "CmFF",
                   )
user.confirm!
user = User.create(
                   first_name: 'Macklin',
                   last_name: 'Chaffee',
                   email: 'ed@ed.asdf',
                   role: 'educator',
                   pin: 'asdfff',
                   password: "EdFF",
                   password_confirmation: "EdFF",
                   )
user.confirm!
