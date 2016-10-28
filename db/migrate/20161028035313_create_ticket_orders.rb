class CreateTicketOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :ticket_orders do |t|
      t.integer :movie_screening_id
      t.decimal :price, precision: 5, scale: 2
      t.boolean :paid, default: false
      t.string :name
      t.string :email
      t.string :credit_card_number
      t.date :expiration_date

      t.timestamps
    end
    add_index :ticket_orders, :movie_screening_id
  end
end
