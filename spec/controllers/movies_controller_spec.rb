require 'rails_helper'

RSpec.describe MoviesController, :type => :controller do
  describe 'POST #create' do
    before :each do 
      @theater = create(:theater)
      @auditorium = create(:auditorium, theater_id: @theater.id)
    end

    context "when a new movie has valid attributes" do
      it "should save the new movie in the database" do   
        expect {
          post :create, theater_id: @theater.id, auditorium_id: @auditorium.id, movie: attributes_for(:movie,
            theater_id: @theater.id,
            auditorium_id: @auditorium.id
          )
        }.to change(Movie, :count).by(1)
      end

      it "should redirect to movies#show" do
        post :create, theater_id: @theater.id, auditorium_id: @auditorium.id, movie: attributes_for(:movie, 
          theater_id: @theater.id,
          auditorium_id: @auditorium.id
        )
        expect(response).to redirect_to theater_movie_path(assigns[:movie], theater_id: @theater.id)

      end
    end

    context "when a new movie has invalid attributes" do 
      it "should not save the movie in the database" do
        expect {
          post :create, theater_id: @theater.id, movie: attributes_for(:invalid_movie, 
            theater_id: @theater.id,
            auditorium_id: @auditorium.id
          )
        }.not_to change(Movie, :count)
      end

      it "should re-render movie :new template" do 
        post :create, theater_id: @theater.id, movie: attributes_for(:invalid_movie, 
          theater_id: @theater.id,
          auditorium_id: @auditorium.id
        )
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      theater = create(:theater)
      auditorium = create(:auditorium, theater_id: theater.id)
      @movie = create(:movie, title: "Test 1", theater_id: theater.id, auditorium_id: auditorium.id) 
    end

    context "when movie is updated with valid attributes" do
      it "should change @movie's attributes" do
        patch :update, theater_id: @movie.theater_id, id: @movie, movie: attributes_for(:movie,
          title: "Test 2"
        )
        @movie.reload
        expect(@movie.title).to eq("Test 2")
      end

      it "should redirect to the updated @movie" do
        patch :update, theater_id: @movie.theater_id, id: @movie, movie: attributes_for(:movie)
        expect(response).to redirect_to theater_movie_path(@movie, theater_id: @movie.theater_id)
      end
    end

    context "when movie is updated with invalid attributes" do
      it "should not change @movie's attributes" do
        patch :update, theater_id: @movie.theater_id, id: @movie, movie: attributes_for(:movie,
          title: "Test 3",
          run_time_minutes: nil
        )
        @movie.reload
        expect(@movie.title).not_to eq("Test 3")
      end

      it "should re-render the movie :edit template " do
        patch :update, theater_id: @movie.theater_id, id: @movie, movie: attributes_for(:invalid_movie)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    context "when user deletes a movie" do

      before :each do
        theater = create(:theater)        
        @delete_movie = create(:movie, theater_id: theater.id)
      end

      it "should allow a user to delete the movie" do   
        expect{ delete :destroy, theater_id: @delete_movie.theater_id, id: @delete_movie}.to change(Movie, :count).by(-1)
      end

      it "should redirect to theater show page" do   
        delete :destroy, theater_id: @delete_movie.theater_id, id: @delete_movie
        expect(response).to redirect_to theater_path(@delete_movie.theater_id)
      end
    end
  end
end