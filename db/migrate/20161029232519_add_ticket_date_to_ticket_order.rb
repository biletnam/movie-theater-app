class AddTicketDateToTicketOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :ticket_orders, :ticket_date, :date
  end
end
