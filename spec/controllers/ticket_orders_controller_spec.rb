require 'rails_helper'

RSpec.describe TicketOrdersController, :type => :controller do
  describe 'POST #create' do
    before :each do 
      @movie_screening = create(:movie_screening)
    end

    context "when a new ticket order has valid attributes" do
      it "should save the new ticket order in the database" do   
        expect {
          post :create, movie_screening_id: @movie_screening.id, ticket_order: attributes_for(:ticket_order, 
            movie_screening_id: @movie_screening.id
          )
        }.to change(TicketOrder, :count).by(1)
      end

      it "should redirect to ticket_orders#show" do
        post :create, movie_screening_id: @movie_screening.id, ticket_order: attributes_for(:ticket_order, 
          movie_screening_id: @movie_screening.id
        )
        expect(response).to redirect_to movie_screening_ticket_order_path(assigns[:ticket_order], movie_screening_id: @movie_screening.id)

      end
    end

    context "when a new ticket order has invalid attributes" do 
      it "should not save the ticket order in the database" do
        expect {
          post :create, movie_screening_id: @movie_screening.id, ticket_order: attributes_for(:ticket_order,
            movie_screening_id: @movie_screening.id,
            name: nil
          )
        }.not_to change(TicketOrder, :count)
      end

      it "should re-render movie :new template" do 
        post :create, movie_screening_id: @movie_screening.id, ticket_order: attributes_for(:invalid_ticket_order,
          movie_screening_id: @movie_screening.id
        )
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do 
      @movie_screening = create(:movie_screening)
      @ticket_order = create(:ticket_order, movie_screening_id: @movie_screening.id)
      @name = "Test Name"
    end

    context "when ticket order is updated with valid attributes" do
      it "should change @ticket_order's attributes" do
        patch :update, movie_screening_id: @movie_screening.id, id: @ticket_order, ticket_order: attributes_for(:ticket_order,
          name: @name
        )
        @ticket_order.reload
        expect(@ticket_order.name).to eq(@name)
      end

      it "should redirect to the updated @ticket_order" do
        patch :update, movie_screening_id: @movie_screening.id, id: @ticket_order.id, ticket_order: attributes_for(:ticket_order,
          name: @name
        )
        expect(response).to redirect_to movie_screening_ticket_order_path(@ticket_order, movie_screening_id: @movie_screening.id)
      end
    end

    context "when ticket_order is updated with invalid attributes" do
      it "should not change @ticket_order's attributes" do
        patch :update, movie_screening_id: @ticket_order.movie_screening_id, id: @ticket_order, ticket_order: attributes_for(:ticket_order,
          name: nil,
          price: 20.00
        )
        @ticket_order.reload
        expect(@ticket_order.price).not_to eq(20.00)
      end

      it "should re-render the ticket_order :edit template " do
        patch :update, movie_screening_id: @ticket_order.movie_screening_id, id: @ticket_order, ticket_order: attributes_for(:invalid_ticket_order)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    context "when user deletes a ticket order" do
      before :each do 
        @movie_screening = create(:movie_screening)
        @delete_ticket_order = create(:ticket_order, movie_screening_id: @movie_screening.id)
      end

      it "should allow a user to delete the movie" do   
        expect{ delete :destroy, movie_screening_id: @delete_ticket_order.movie_screening_id, id: @delete_ticket_order}.to change(TicketOrder, :count).by(-1)
      end

      it "should redirect to theater show page" do   
        delete :destroy, movie_screening_id: @delete_ticket_order.movie_screening_id, id: @delete_ticket_order
        expect(response).to redirect_to theater_path(@movie_screening.theater_id)
      end
    end
  end
end