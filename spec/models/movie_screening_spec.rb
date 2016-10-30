require 'rails_helper'

RSpec.describe MovieScreening, :type => :model do
  it 'has a valid factory' do
    expect(build(:movie_screening)).to be_valid
  end

  context "when there are model methods" do
    it "returns a movie screening's start time hours in 10:00 AM/PM format" do
      movie_screening = build(:movie_screening,
        start_time: Time.parse("2016-10-29 10:00:00")
      )

      expect(movie_screening.friendly_start_time).to eq("10:00 AM")
    end 

    it "returns a movie screening's date in Oct 29, 2016 format" do
      movie_screening = build(:movie_screening,
        screening_date: Date.new(2016,10,29)
      )

      expect(movie_screening.friendly_screening_date).to eq("Oct 29, 2016")
    end

    it "returns true if screening date is before than today's date, else false" do
      movie_screening_valid_date = build(:movie_screening,
        screening_date: Date.today
      )

      movie_screening_invalid_date = build(:movie_screening,
        screening_date: Date.new(2016,10,20)
      )

      expect(movie_screening_valid_date.date_invalid_purchase?).to eq(false)
      expect(movie_screening_invalid_date.date_invalid_purchase?).to eq(true)
    end 

    it "returns total tickets sold count for a movie screening" do
      movie_screening_one = create(:movie_screening,
        screening_date: Date.new(2016,10,29)
      )
      movie_screening_two = create(:movie_screening,
        screening_date: Date.new(2016,10,28)
      )  

      ticket_order_1 = create(:ticket_order,
        movie_screening_id: movie_screening_one.id
      )
      ticket_order_2 = create(:ticket_order,
        movie_screening_id: movie_screening_one.id
      )
      ticket_order_3 = create(:ticket_order,
        movie_screening_id: movie_screening_two.id
      )

      expect(movie_screening_one.tickets_sold).to eq(2)
    end

    it "returns total tickets remaining count for a movie screening" do
      auditorium = create(:auditorium, 
        seating_capacity: 3
      )
      movie = create(:movie, 
        auditorium_id: auditorium.id
      )
      movie_screening = create(:movie_screening,
        movie_id: movie.id
      )
      ticket_order_1 = create(:ticket_order,
        movie_screening_id: movie_screening.id
      )

      expect(movie_screening.movie.auditorium.seating_capacity).to eq(3)
      expect(movie_screening.tickets_remaining).to eq(2)
    end

    it "return true if tickets remaining > 0" do
      auditorium = create(:auditorium, 
        seating_capacity: 1
      )
      movie = create(:movie, 
        auditorium_id: auditorium.id
      )
      movie_screening = create(:movie_screening,
        movie_id: movie.id
      )
      ticket_order_1 = create(:ticket_order,
        movie_screening_id: movie_screening.id
      )

      expect(movie_screening.movie.auditorium.seating_capacity).to eq(1)
      expect(movie_screening.tickets_remaining).to eq(0)
      expect(movie_screening.sold_out?).to eq(true)
    end

    it "returns 'disabled' if movie screening is sold out/has no tickets remaining" do
      auditorium = create(:auditorium, 
        seating_capacity: 1
      )
      movie = create(:movie, 
        auditorium_id: auditorium.id
      )
      movie_screening = create(:movie_screening,
        movie_id: movie.id
      )
      ticket_order_1 = create(:ticket_order,
        movie_screening_id: movie_screening.id
      )

      expect(movie_screening.sold_out?).to eq(true)
      expect(movie_screening.disable_screening).to eq("disabled")
    end
  end
end