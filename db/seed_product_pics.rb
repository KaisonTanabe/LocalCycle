Product.all.each do |p|
  begin
    p.pic = File.open("#{Rails.root}/app/assets/images/product_pics/#{p.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}.jpg")
    p.save!
    puts "Found: #{Rails.root}/app/assets/images/product_pics/#{p.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}.jpg"
  rescue 
    next
  end
end
