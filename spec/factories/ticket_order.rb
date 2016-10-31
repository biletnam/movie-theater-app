FactoryGirl.define do 
  factory :ticket_order do 
    association :movie_screening
    price 10.00
    paid false
    name Faker::Name.name
    email Faker::Internet.email
    credit_card_number ENV['test_cc_number']
    expiration_date Date.today
    ticket_date Date.today
    
    factory :invalid_ticket_order do 
      name nil
    end
  end
end