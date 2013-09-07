class CreateTableForGoodCertifications < ActiveRecord::Migration
  def up
    create_table :certifications_goods, id: false do |t|
      t.integer :certification_id
      t.integer :good_id
    end
    
  end

  def down
  end
end
