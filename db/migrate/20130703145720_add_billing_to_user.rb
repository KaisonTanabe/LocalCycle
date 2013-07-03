class AddBillingToUser < ActiveRecord::Migration
  def change
    add_column :users,  :billing_street_address_1, :string
    add_column :users,  :billing_street_address_2, :string
    add_column :users,  :billing_city,             :string
    add_column :users,  :billing_state,            :string
    add_column :users,  :billing_country,          :string,    default: "US"
    add_column :users,  :billing_zip,              :string
  end
end
