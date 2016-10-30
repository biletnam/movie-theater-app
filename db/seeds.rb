# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Theater.destroy_all
Auditorium.destroy_all
Movie.destroy_all
MovieScreening.destroy_all

theater = Theater.create(
  name: "AMC " + Faker::Lorem.word,
  manager: Faker::Name.name,
  street_address: Faker::Address.street_address,
  city: Faker::Address.city,
  state: Faker::Address.state_abbr,
  zip: Faker::Address.zip
)

capacities = [2,3,5]
counter = 1

3.times do 

  aud = Auditorium.create(
    theater_id: theater.id,
    name: counter,
    seating_capacity: capacities.sample
  )

  3.times do 
    movie = Movie.create(
      theater_id: theater.id,
      auditorium_id: aud.id,
      title: Faker::Superhero.name,
      run_time_minutes: [123, 108, 110, 115, 139].sample,
      ticket_price: [8.00, 10.00, 12.00].sample
    )

    t1 = Time.parse("2016-10-29 10:00:00")
    t2 = Time.parse("2016-10-29 22:00:00")

    2.times do 
      screening = MovieScreening.create(
        movie_id: movie.id,
        start_time: rand(t1..t2),
        theater_id: theater.id,
        screening_date: Date.today
      )
    end

    2.times do 
      screening = MovieScreening.create(
        movie_id: movie.id,
        start_time: rand(t1..t2),
        theater_id: theater.id,
        screening_date: Date.today + 1.day
      )
    end

    2.times do 
      screening = MovieScreening.create(
        movie_id: movie.id,
        start_time: rand(t1..t2),
        theater_id: theater.id,
        screening_date: Date.today + 2.day
      )
    end
  end
  counter += 1
end

puts "Seed complete!"





