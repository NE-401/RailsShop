# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

CSV.foreach("db/products.csv") do |row|
	Product.create(:name => row[0], :publisher => row[1], :category => row[2], :price => row[3], :stock => row[4], :image => open("#{Rails.root}/product_images/"+row[5]))
end
