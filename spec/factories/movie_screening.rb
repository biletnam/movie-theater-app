FactoryGirl.define do 
  factory :movie_screening do 
    association :movie
    association :theater
    screening_date Date.today
    start_time Time.now
    end_time Time.now
    
    factory :invalid_movie_screening do 
      screening_date nil
    end
  end
end