puts "Altering Product/Category Tree"

b = Category.where(name: "Baked Goods").first
b.update_column("name", "Specialty")
Category.where(name: "Pantry").first.children.each do |c|
  b.add_child(c)
end
Category.where(name: "Pantry").first.delete

Category.leaves.each do |c|
  unless Product.where(name: c.name).any?
    Product.create(name: c.name, category_id: c.id) 
  end
end
