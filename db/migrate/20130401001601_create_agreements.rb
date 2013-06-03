class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.integer    :buyer_id,         null: false, default: 0
      t.integer    :producer_id,      null: false, default: 0
      t.integer    :creator_id,       null: false               # Same as one of the above

      t.string     :agreement_type,   null: false

      t.references :product,          null: false
      t.string     :name,             null: false
      t.text       :description

      t.string     :frequency
      t.date       :start_date
      t.date       :end_date

      t.float      :price,               null: false
      t.integer    :quantity,            null: false
      t.string     :selling_unit,        null: false

      t.boolean    :locally_packaged,    null: false, default: false

      t.string     :transport_by
      t.text       :transport_instructions

      t.timestamps
    end

    add_index :agreements, :buyer_id
    add_index :agreements, :producer_id
    add_index :agreements, :creator_id
  end
end
