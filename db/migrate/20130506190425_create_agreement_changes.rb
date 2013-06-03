class CreateAgreementChanges < ActiveRecord::Migration
  def change
    create_table :agreement_changes do |t|
      t.references   :agreement,        null: false
      t.references   :agreement_change, null: false, default: 0
      t.integer      :user_id,          null: false

      t.string       :status,           null: false, default: "pending"

      t.float        :price
      t.integer      :quantity
      t.string       :frequency
      t.string       :transport_by
      t.text         :transport_instructions
      t.text         :reason

      t.timestamps
    end
    
    add_index :agreement_changes, :agreement_id
    add_index :agreement_changes, :agreement_change_id
    add_index :agreement_changes, :user_id
  end
end
