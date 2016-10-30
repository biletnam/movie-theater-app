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
  end
end