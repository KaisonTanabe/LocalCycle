class CreateCounterAgreements < ActiveRecord::Migration
  def change
    create_table :counter_agreements do |t|
      t.integer      :price
      t.integer      :quantity
      t.text         :reasons
      t.references   :agreement,   null: false
      t.references   :user,        null: false
      
      t.timestamps
    end
  end
end
