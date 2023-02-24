# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb
User.create!(email: 'user1@example.com', password: 'password')
User.create!(email: 'user2@example.com', password: 'password')

Spot.create!(
  title: 'Spacious Apartment in Manhattan',
  description: 'Beautifully renovated apartment in the heart of Manhattan.',
  price: 250,
  user_id: 1
)

Spot.create!(
  title: 'Luxury Condo in Los Angeles',
  description: 'Stunning 3-bedroom condo in the heart of Los Angeles.',
  price: 350,
  user_id: 2
)

Review.create!(
  rating: 5,
  comment: 'Absolutely loved the apartment! Would definitely stay here again.',
  user_id: 2,
  spot_id: 1
)

Review.create!(
  rating: 4,
  comment: 'Great location and beautiful views.',
  user_id: 1,
  spot_id: 2
)
