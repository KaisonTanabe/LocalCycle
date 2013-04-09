class CreateCertificationsProducerProfiles < ActiveRecord::Migration
  def change
    create_table :certifications_producer_profiles do |t|
      t.references :certification,    null: false
      t.references :producer_profile, null: false
    end

    add_index :certifications_producer_profiles, :certification_id
    add_index :certifications_producer_profiles, :producer_profile_id
  end
end
