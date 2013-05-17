class CreatePreferredProducerAgreements < ActiveRecord::Migration
  def change
    create_table :preferred_producer_agreements do |t|
      t.references :agreement, null: false
      t.references :producer_profile, null: false

      t.timestamps
    end
    add_index :preferred_producer_agreements, :agreement_id
    add_index :preferred_producer_agreements, :producer_profile_id
  end
end
