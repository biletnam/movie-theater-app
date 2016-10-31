require 'rails_helper'

RSpec.describe Movie, :type => :model do
  it 'has a valid factory' do
    expect(build(:movie)).to be_valid
  end

  context "when there are model methods" do
    it "returns a movie's run time hours in #hours #minutes" do
      movie_one = build(:movie)
      movie_two = build(:movie, 
        run_time_minutes: 120
      )

      expect(movie_one.run_time_hours).to eq("1 hour 40 minutes")
      expect(movie_two.run_time_hours).to eq("2 hours")
    end 

    it "returns total ticket order count for a movie" do
      movie_screening = create(:movie_screening)
      movie = Movie.find(movie_screening.movie_id)

      ticket_order_1 = create(:ticket_order,
        movie_screening_id: movie_screening.id
      )
      ticket_order_2 = create(:ticket_order,
        movie_screening_id: movie_screening.id
      )

      expect(movie.total_orders).to eq(2)
    end

    it "orders movies by number of tickets sold, descending" do
      movie_one = create(:movie)
      movie_screening_one = create(:movie_screening, movie_id: movie_one.id)
      create(:ticket_order, movie_screening_id: movie_screening_one.id)
    
      movie_two = create(:movie)
      movie_screening_two = create(:movie_screening, movie_id: movie_two.id)
      create(:ticket_order, movie_screening_id: movie_screening_two.id)
      create(:ticket_order, movie_screening_id: movie_screening_two.id)

      movie_three = create(:movie)
      movie_screening_three = create(:movie_screening, movie_id: movie_three.id)
      create(:ticket_order, movie_screening_id: movie_screening_three.id)
      create(:ticket_order, movie_screening_id: movie_screening_three.id)
      create(:ticket_order, movie_screening_id: movie_screening_three.id)

      ordered_movies = Movie.all.order_by_tickets_sold

      expect(ordered_movies.first).to eq(movie_three)
      expect(ordered_movies.last).to eq(movie_one)
    end
  end
end