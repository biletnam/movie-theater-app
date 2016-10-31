require 'rails_helper'

RSpec.describe TheatersController, :type => :controller do
  describe 'POST #create' do
    context "when a new theater has valid attributes" do
      it "should save the new theater in the database" do   
        expect {
          post :create, theater: attributes_for(:theater)
        }.to change(Theater, :count).by(1)
      end

      it "should redirect to theaters#show" do
        post :create, theater: attributes_for(:theater)
        expect(response).to redirect_to theater_path(assigns[:theater])
      end
    end

    context "when a new theater has invalid attributes" do 
      it "should not save the theater in the database" do   
        expect {
          post :create, theater: attributes_for(:invalid_theater)
        }.not_to change(Theater, :count)
      end

      it "should re-render theater :new template" do 
        post :create, theater: attributes_for(:invalid_theater)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @theater = create(:theater, city: "Chicago") 
    end

    context "when theater is updated with valid attributes" do
      it "should change @theater's attributes" do
        patch :update, id: @theater, theater: attributes_for(:theater,
          name: "AMC Testing"
        )
        @theater.reload
        expect(@theater.name).to eq("AMC Testing")
      end

      it "should redirect to the updated @theater" do
        patch :update, id: @theater, theater: attributes_for(:theater)
        expect(response).to redirect_to theater_path(@theater)
      end
    end

    context "when theater is updated with invalid attributes" do
      it "should not change @theater's attributes" do
        patch :update, id: @theater, theater: attributes_for(:theater,
          name: "AMC Testing",
          city: "Evanston",
          state: nil)
        @theater.reload
        expect(@theater.name).not_to eq("AMC Testing")
        expect(@theater.city).to eq("Chicago")
      end

      it "should re-render the theater :edit template " do
        patch :update, id: @theater, theater: attributes_for(:invalid_theater)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    context "when user deletes a theater" do

      before :each do        
        @delete_theater = create(:theater)
      end

      it "should allow a user to delete the theater" do   
        expect{ delete :destroy, id: @delete_theater}.to change(Theater, :count).by(-1)
      end

      it "should redirect to theater index" do   
        delete :destroy, id: @delete_theater
        expect(response).to redirect_to theaters_path
      end
    end
  end
end