class CreateAgreementChanges < ActiveRecord::Migration
  def change
    create_table :agreement_changes do |t|
      t.references   :agreement,   null: false
      t.references   :producer,    null: false, default: 0
      t.references   :buyer,       null: false, default: 0

      t.boolean      :agree,       null: false, default: false

      t.integer      :price
      t.integer      :quantity
      t.string       :frequency
      t.string       :transport_by
      t.string       :transport_fee
      t.text         :transport_instructions
      t.text         :reasons

      t.timestamps
    end
    
    add_index :agreement_changes, :agreement_id
    add_index :agreement_changes, :producer_id
    add_index :agreement_changes, :buyer_id
  end
end
