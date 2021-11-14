# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
User.create!({ email: "admin@test.com",
               password: "admin@test.com",
               password_confirmation: "admin@test.com",
               admin: true })

User.create!({ email: "user@test.com",
               password: "user@test.com",
               password_confirmation: "user@test.com" })

Book.delete_all
50.times do
  Book.create!({
    title: Faker::Book.title,
    author: Faker::Book.author,
    genre: Faker::Book.genre,
    price: rand(1..100),
  })
end
