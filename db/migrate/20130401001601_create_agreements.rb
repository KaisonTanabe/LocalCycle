class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.integer    :buyer_id,         null: false, default: 0
      t.integer    :producer_id,      null: false, default: 0

      t.string     :agreement_type,   null: false

      t.references :product,          null: false
      t.string     :name,             null: false
      t.text       :description

      t.string     :frequency
      t.date       :start_date
      t.date       :end_date

      t.float      :price,            null: false
      t.float      :quantity,         null: false
      t.string     :selling_unit,     null: false

      t.boolean    :locally_packaged, null: false, default: false

      t.string     :transport_by,        null: false
      t.float      :transport_fee,       null: false, default: 0
      t.text       :transport_instructions

      t.timestamps
    end
  end
end
