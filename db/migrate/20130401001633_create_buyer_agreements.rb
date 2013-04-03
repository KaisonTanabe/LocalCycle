class CreateBuyerAgreements < ActiveRecord::Migration
  def change
    create_table :buyer_agreements do |t|
      t.references :user
      t.references :agreement

      t.timestamps
    end
    add_index :buyer_agreements, :user_id
    add_index :buyer_agreements, :agreement_id
  end
end
