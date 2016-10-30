FactoryGirl.define do 
  factory :theater do 
    name "AMC " + Faker::Lorem.word
    manager Faker::Name.name
    street_address Faker::Address.street_address
    city Faker::Address.city
    state Faker::Address.state_abbr
    zip Faker::Address.zip

    factory :invalid_theater do 
      name nil
    end
  end
end