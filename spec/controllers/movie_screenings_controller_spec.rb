require 'rails_helper'

RSpec.describe MovieScreeningsController, :type => :controller do
  describe 'POST #create' do
    before :each do 
      @theater = create(:theater)
      @auditorium = create(:auditorium, theater_id: @theater.id)
      @movie = create(:movie, theater_id: @theater.id, auditorium_id: @auditorium.id)
      @start_time = Time.now
    end

    context "when a new movie screening has valid attributes" do
      it "should save the new movie screening in the database" do   
        expect {
          post :create, movie_id: @movie.id, movie_screening: attributes_for(:movie_screening, 
          theater_id: @theater.id,
          movie_id: @movie.id
        )
        }.to change(MovieScreening, :count).by(1)
      end

      it "should redirect to movie_screenings#show" do
        post :create, movie_id: @movie.id, movie_screening: attributes_for(:movie_screening, 
          theater_id: @theater.id,
          movie_id: @movie.id
        )
        expect(response).to redirect_to movie_movie_screening_path(assigns[:movie_screening], movie_id: @movie.id)

      end
    end

    context "when a new movie screening has invalid attributes" do 
      it "should not save the movie screening in the database" do
        expect {
          post :create, movie_id: @movie.id, movie_screening: attributes_for(:movie_screening,
          theater_id: @theater.id,
          movie_id: @movie.id,
          start_time: nil
          )
        }.not_to change(MovieScreening, :count)
      end

      it "should re-render movie :new template" do 
        post :create, movie_id: @movie.id, movie_screening: attributes_for(:invalid_movie_screening, theater_id: @theater.id,
          movie_id: @movie.id)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @theater = create(:theater)
      @auditorium = create(:auditorium, theater_id: @theater.id)
      @movie = create(:movie, theater_id: @theater.id, auditorium_id: @auditorium.id)
      @movie_screening = create(:movie_screening, theater_id: @theater.id, movie_id: @movie.id)

      @freezed_time = Time.utc(2000, 1, 1, 10, 0, 0) 
    end

    context "when movie screening is updated with valid attributes" do
      it "should change @movie_screening's attributes" do
        patch :update, movie_id: @movie.id, id: @movie_screening, movie_screening: attributes_for(:movie_screening,
          start_time: @freezed_time
        )
        @movie_screening.reload
        expect(@movie_screening.start_time).to eq(@freezed_time)
      end

      it "should redirect to the updated @movie_screening" do
        patch :update, movie_id: @movie.id, id: @movie_screening.id, movie_screening: attributes_for(:movie_screening,
          start_time: @freezed_time
        )
        expect(response).to redirect_to movie_movie_screening_path(@movie_screening, movie_id: @movie.id)
      end
    end

    context "when movie_screening is updated with invalid attributes" do
      it "should not change @movie_screening's attributes" do
        patch :update, movie_id: @movie_screening.movie_id, id: @movie_screening, movie_screening: attributes_for(:movie_screening,
          start_time: nil,
          screening_date: Date.new(2016,10,10)
        )
        @movie_screening.reload
        expect(@movie_screening.screening_date).not_to eq(Date.new(2016,10,10))
      end

      it "should re-render the movie_screening :edit template " do
        patch :update, movie_id: @movie_screening.movie_id, id: @movie_screening, movie_screening: attributes_for(:invalid_movie_screening)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    context "when user deletes a movie screening" do

      before :each do
      @theater = create(:theater)
      @auditorium = create(:auditorium, theater_id: @theater.id)
      @movie = create(:movie, theater_id: @theater.id, auditorium_id: @auditorium.id)
      @delete_movie_screening = create(:movie_screening, theater_id: @theater.id, movie_id: @movie.id)
    end

      it "should allow a user to delete the movie" do   
        expect{ delete :destroy, movie_id: @delete_movie_screening.movie_id, id: @delete_movie_screening}.to change(MovieScreening, :count).by(-1)
      end

      it "should redirect to theater show page" do   
        delete :destroy, movie_id: @delete_movie_screening.movie_id, id: @delete_movie_screening
        expect(response).to redirect_to theater_path(@delete_movie_screening.theater_id)
      end
    end
  end
end