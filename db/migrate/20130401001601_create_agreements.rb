class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.references :product,         null: false
      t.integer    :buyer_id
      t.integer    :producer_id

      t.string     :name,             null: false
      t.text       :description

      t.string     :agreement_type,   null: false
      t.string     :frequency
      t.date       :start_date,       null: false, default: Date.today
      t.date       :end_date

      t.float      :quantity,         null: false
      t.string     :selling_unit,     null: false

      t.float      :price,            null: false

      t.boolean    :locally_packaged, null: false

      t.boolean    :can_deliver,      null: false, default: false
      t.text       :delivery_options
      t.float      :min_delivery_quantity
      t.float      :max_delivery_quantity
      t.boolean    :can_pickup,       null: false, default: false
      t.text       :pickup_options
      t.float      :min_pickup_quantity
      t.float      :max_pickup_quantity

      t.timestamps
    end
  end
end
