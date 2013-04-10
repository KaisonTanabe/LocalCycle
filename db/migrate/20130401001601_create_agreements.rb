class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.references :product,         null: false
      t.integer    :buyer_id,         null: false
      t.integer    :producer_id,      null: false

      t.string     :name,             null: false
      t.text       :description

      t.string     :agreement_type,   null: false, default: "onetime"
      t.date       :start_date,       null: false, default: Date.today
      t.date       :end_date,         null: false, default: (Date.today + 1.week)

      t.float      :quantity,         null: false
      t.string     :selling_unit,     null: false

      t.float      :price,            null: false

      t.boolean    :locally_packaged, null: false
      t.boolean    :can_deliver,      null: false, default: false
      t.text       :delivery_options
      t.boolean    :can_pickup,       null: false, default: false
      t.text       :pickup_options

      t.timestamps
    end
  end
end
