class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.string :name,           null: false
      t.string :cert_type,      null: false, default: "producer"
      t.boolean :audited,       null: false, default: false

      t.timestamps
    end
  end
end
