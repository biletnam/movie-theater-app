require 'rails_helper'

RSpec.describe AuditoriaController, :type => :controller do
  describe 'POST #create' do
    before :each do 
      @theater = create(:theater)
    end

    context "when a new auditorium has valid attributes" do
      it "should save the new auditorium in the database" do   
        expect {
          post :create, theater_id: @theater.id, auditorium: attributes_for(:auditorium, theater_id: @theater.id)
        }.to change(Auditorium, :count).by(1)
      end

      it "should redirect to auditoriums#show" do
        post :create, theater_id: @theater.id, auditorium: attributes_for(:auditorium, theater_id: @theater.id)
        expect(response).to redirect_to theater_auditorium_path(assigns[:auditorium], theater_id: @theater.id)

      end
    end

    context "when a new auditorium has invalid attributes" do 
      it "should not save the auditorium in the database" do
        expect {
          post :create, theater_id: @theater.id, auditorium: attributes_for(:invalid_auditorium, theater_id: @theater.id)
        }.not_to change(Auditorium, :count)
      end

      it "should re-render auditorium :new template" do 
        post :create, theater_id: @theater.id, auditorium: attributes_for(:invalid_auditorium, theater_id: @theater.id)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      theater = create(:theater)
      @auditorium = create(:auditorium, name: "Test 1", theater_id: theater.id) 
    end

    context "when auditorium is updated with valid attributes" do
      it "should change @auditorium's attributes" do
        patch :update, theater_id: @auditorium.theater_id, id: @auditorium, auditorium: attributes_for(:auditorium,
          name: "Test 2", 
          theater_id: @auditorium.theater_id
        )
        @auditorium.reload
        expect(@auditorium.name).to eq("Test 2")
      end

      it "should redirect to the updated @auditorium" do
        patch :update, theater_id: @auditorium.theater_id, id: @auditorium, auditorium: attributes_for(:auditorium, 
          theater_id: @auditorium.theater_id
        )
        expect(response).to redirect_to theater_auditorium_path(@auditorium, theater_id: @auditorium.theater_id)
      end
    end

    context "when auditorium is updated with invalid attributes" do
      it "should not change @auditorium's attributes" do
        patch :update, theater_id: @auditorium.theater_id, id: @auditorium, auditorium: attributes_for(:auditorium,
          name: "Test 3",
          seating_capacity: nil,
          theater_id: @auditorium.theater_id,
        )
        @auditorium.reload
        expect(@auditorium.name).not_to eq("Test 3")
      end

      it "should re-render the auditorium :edit template " do
        patch :update, theater_id: @auditorium.theater_id, id: @auditorium, auditorium: attributes_for(:invalid_auditorium, 
          theater_id: @auditorium.theater_id
        )
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    context "when user deletes an auditorium" do

      before :each do
        theater = create(:theater)        
        @delete_auditorium = create(:auditorium, theater_id: theater.id)
      end

      it "should allow a user to delete the auditorium" do   
        expect{ delete :destroy, theater_id: @delete_auditorium.theater_id, id: @delete_auditorium}.to change(Auditorium, :count).by(-1)
      end

      it "should redirect to theater show page" do   
        delete :destroy, theater_id: @delete_auditorium.theater_id, id: @delete_auditorium
        expect(response).to redirect_to theater_path(@delete_auditorium.theater_id)
      end
    end
  end
end