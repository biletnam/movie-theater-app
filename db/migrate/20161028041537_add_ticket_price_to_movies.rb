class AddTicketPriceToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :ticket_price, :decimal, precision: 5, scale: 2
  end
end
