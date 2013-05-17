class CreateDeliveryWindows < ActiveRecord::Migration
  def change
    create_table :delivery_windows do |t|
      t.integer :deliverable_id
      t.string  :deliverable_type

      t.integer :weekday
      t.integer :start_hour
      t.integer :end_hour

      t.timestamps
    end
  end
end
