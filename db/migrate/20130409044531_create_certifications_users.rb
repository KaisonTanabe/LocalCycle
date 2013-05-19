class CreateCertificationsUsers < ActiveRecord::Migration
  def change
    create_table :certifications_users do |t|
      t.references :certification,    null: false
      t.references :user,             null: false
    end

    add_index :certifications_users, :certification_id
    add_index :certifications_users, :user_id
  end
end
