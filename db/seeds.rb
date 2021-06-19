# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"
# TODO: Write a seed to insert 100 posts in the database

puts "destroying meals"
Meal.destroy_all
puts "destroyed"
10.times do
    user = User.create!(name: Faker::FunnyName.name, description: Faker::Hipster.sentences(number: 1), email: Faker::Internet.email, password: 111111)
    rand(5).times do
      meal = Meal.create!(name: Faker::Food.dish, description: Faker::Food.description, price: rand(10..500), user: user)
    end
end

5.times do
 booking = Booking.create!(date: DateTime.now + 1.day, location: "Shenzhen" ,user: User.all.sample, meal: Meal.all.sample)
end

puts "created #{Meal.count} meals"
