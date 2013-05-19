class CreatePreferredUserAgreements < ActiveRecord::Migration
  def change
    create_table :preferred_user_agreements do |t|
      t.references :agreement, null: false
      t.references :user, null: false

      t.timestamps
    end
    add_index :preferred_user_agreements, :agreement_id
    add_index :preferred_user_agreements, :user_id
  end
end
