FactoryGirl.define do 

  factory :auditorium do 
    association :theater
    name Faker::Lorem.word
    seating_capacity 10

    factory :invalid_auditorium do 
      name nil
    end
  end
end