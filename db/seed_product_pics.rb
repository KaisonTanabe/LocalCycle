Product.all.each do |p|
  begin
    p.pic = File.open("#{Rails.root}/app/assets/images/product_pics/#{p.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}.jpg")
    p.save!
    puts "Found Product: #{Rails.root}/app/assets/images/product_pics/#{p.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}.jpg"
  rescue 
    next
  end
end

Category.roots.each do |c|
  begin
    c.pic = File.open("#{Rails.root}/app/assets/images/category_pics/#{c.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}.jpg")
    c.save!
    puts "Found category: #{Rails.root}/app/assets/images/category_pics/#{c.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}.jpg"
  rescue
    next
  end
end
