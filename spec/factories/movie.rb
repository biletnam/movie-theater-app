FactoryGirl.define do 
  factory :movie do 
    association :theater
    association :auditorium
    title Faker::Superhero.name
    run_time_minutes 100
    ticket_price 10.00
    
    factory :invalid_movie do 
      title nil
    end
  end
end