# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

theater = Theater.create(
  name: Faker::Lorem.word,
  manager: Faker::Name.name,
  street_address: Faker::Address.street_address,
  city: Faker::Address.city,
  state: Faker::Address.state_abbr,
  zip: Faker::Address.zip
)

capacities = [10,15,20]

5.times do 
  counter = 1

  Auditorium.create(
    theater_id: theater.id,
    name: counter,
    seating_capacity: capacities.sample
  )

  counter += 1
end





