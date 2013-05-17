class CreatePreferredBuyerAgreements < ActiveRecord::Migration
  def change
    create_table :preferred_buyer_agreements do |t|
      t.references :agreement, null: false
      t.references :buyer_profile, null: false

      t.timestamps
    end
    add_index :preferred_buyer_agreements, :agreement_id
    add_index :preferred_buyer_agreements, :buyer_profile_id
  end
end
