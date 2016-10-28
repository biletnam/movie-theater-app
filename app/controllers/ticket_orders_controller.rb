class TicketOrdersController < ApplicationController
  before_action :set_movie_screening
  before_action :set_ticket_order, only: [:show, :edit, :update, :destroy]
  
  def index
    @ticket_orders = @movie_screening.ticket_orders
  end

  def new
    @ticket_order = TicketOrder.new
  end

  def create
    @ticket_order = TicketOrder.new(ticket_order_params)

    if @ticket_order.save
      flash[:success] = "New movie screening successfully added!"
      redirect_to movie_screening_ticket_order_path(@movie_screening, @ticket_order)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @ticket_order.update(ticket_order_params)
      flash[:success] = "Ticket order was successfully updated!"
      redirect_to movie_screening_ticket_order_path(@movie_screening, @ticket_order)
    else
      render :edit
    end
  end

  def destroy
    if @ticket_order.destroy
      redirect_to movie_screening_ticket_orders_path(@movie_screening)
    else
      flash[:warning] = "Unable to delete the ticket order"
      redirect_to movie_screening_ticket_order_path(@movie_screening, @ticket_order)
    end
  end

  private

    def set_movie_screening
      @movie_screening = MovieScreening.find(params[:movie_screening_id])
    end

    def set_ticket_order
      @ticket_order = TicketOrder.find(params[:id])
    end

    def ticket_order_params
      params.require(:ticket_order).permit(
        :movie_screening_id,
        :price,
        :paid,
        :name,
        :email,
        :credit_card_number,
        :expiration_date
      )
    end
end
