class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,               null: false, default: ""
      t.string :encrypted_password,  null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count,                  default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token

      t.string  :name

      t.string  :street_address_1
      t.string  :street_address_2
      t.string  :city
      t.string  :state
      t.string  :country,                        default: "US"
      t.string  :zip
      
      t.float   :lat
      t.float   :lng
      t.string  :latlong
      
      t.string  :phone
      
      t.text    :description
      t.string  :website
      t.string  :twitter
      t.string  :facebook

      t.integer :size

      t.integer :growing_methods
      t.text    :custom_growing_methods

      t.boolean :has_eggs,           null: false, default: false
      t.boolean :has_livestock,      null: false, default: false
      t.boolean :has_dairy,          null: false, default: false
      t.boolean :has_pantry,         null: false, default: false

      t.boolean :text_updates,       null: false, default: true

      t.string  :transport_by

      t.boolean :complete,           null: false, default: false

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end
end
