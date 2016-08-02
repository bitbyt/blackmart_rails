# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



User.create!(name:  "The Admin User",
             email: "adminuser@blackmart.con",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Prima ry User",
            email: "prima@blackmart.con",
            password:              "password",
            password_confirmation: "password",
            activated: true,
            activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@blackmart.con"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end


# Following relationships
users = User.all
user  = users.first
following = users[2..51]
followers = users[3..41]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

Brand.create! name: "Black Rabbit"
Brand.create! name: "Prima Donna"
Brand.create! name: "Emperor Ming's"
Brand.create! name: "Choke"
Brand.create! name: "Ronald McDonald Trump"
Brand.create! name: "Los Pollos Hermanos"

Category.create! name: "Drugs"
Category.create! name: "Slaves"
Category.create! name: "Animal Parts"
Category.create! name: "Weapons"
Category.create! name: "Organs"
Category.create! name: "Jewellery"

Product.create! name: "Sky Blue", price: 1435.53, description: "Walt's special blend.", brand_id: 6, category_id: 1, active: true
Product.create! name: "Pack of Kidneys", price: 4456.97, description: "Two for the price of one!", brand_id: 5, category_id: 5, active: true
Product.create! name: "Carton of tusks", price: 11245.99, description: "For extinction!", brand_id: 1, category_id: 3, active: true


OrderStatus.delete_all
OrderStatus.create! id: 1, name: "In Progress"
OrderStatus.create! id: 2, name: "Placed"
OrderStatus.create! id: 3, name: "Shipped"
OrderStatus.create! id: 4, name: "Cancelled"
