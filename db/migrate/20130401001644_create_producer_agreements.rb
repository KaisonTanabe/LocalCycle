class CreateProducerAgreements < ActiveRecord::Migration
  def change
    create_table :producer_agreements do |t|
      t.references :user
      t.references :agreement

      t.timestamps
    end
    add_index :producer_agreements, :user_id
    add_index :producer_agreements, :agreement_id
  end
end
