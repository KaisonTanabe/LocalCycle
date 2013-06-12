desc "Seeding selling units"
task :seed_selling_units => :environment do
  UNIT_TYPE.each do |u|
    SellingUnit.create(name: u.second, short_name: u.first)
  end
  Product.all.each do |p|
    ids = [SellingUnit.where(short_name: p.unit_type).first.id]
    p.update_attributes(selling_unit_ids: ids)
  end
end

desc "EMAILING list of ineligible students to admins"
task :seed_products => :environment do
  
  Product.all.each do |p|
    begin
      p.pic = File.open("app/assets/images/product_pics/#{p.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}.jpg")
      p.save!
      puts "Found Product: app/assets/images/product_pics/#{p.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}.jpg"
    rescue 
      next
    end
  end
  
  Category.roots.each do |c|
    begin
      c.pic = File.open("app/assets/images/category_pics/#{c.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}.jpg")
      c.save!
      puts "Found category: app/assets/images/category_pics/#{c.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}.jpg"
    rescue
      next
    end
  end
end

task :seed_subcategory_pics => :environment do
  Category.leaves.each do |c|
    begin
      c.pic = File.open("#{Rails.root}/app/assets/images/subcategory_pics/#{c.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}.jpg")
      c.save!
      puts "Found category: #{Rails.root}/app/assets/images/subcategory_pics/#{c.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}.jpg"
    rescue => error
      puts error.message
      next
    end
  end
end

task :fix_products => :environment do  
  Product.all.each do |p|
    puts Category.where(id: p.category_id).first.name + " " + p.name if Product.where(name: p.name).count > 1
  end
end

task :agreements_nil_to_zero => :environment do  
  Agreement.all.each do |a|
    a.update_column("producer_id", 0) if a.producer_id == nil
    a.update_column("buyer_id", 0) if a.buyer_id == nil
  end
end
