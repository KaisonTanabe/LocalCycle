class AddSizeToProducers < ActiveRecord::Migration
  def change
    add_column :producer_profiles, :size, :string, null: false, default: "small"
  end
end
