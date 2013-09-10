class AddDelivererToDeliveryWindows < ActiveRecord::Migration
  def change
    add_column :delivery_windows, :transport_by, :string
    remove_column :agreement_changes, :transport_by
    remove_column :agreements, :transport_by
    #remove_column :users, :transport_by
  end
end
