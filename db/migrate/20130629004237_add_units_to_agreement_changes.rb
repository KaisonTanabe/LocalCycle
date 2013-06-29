class AddUnitsToAgreementChanges < ActiveRecord::Migration
  def change
    add_column :agreement_changes, :selling_unit, :string
  end
end
