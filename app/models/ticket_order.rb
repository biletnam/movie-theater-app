class TicketOrder < ApplicationRecord
  belongs_to :movie_screening

  validates :movie_screening_id, :price, :name, :email, :credit_card_number, :expiration_date, presence: true
  validates :movie_screening_id, numericality: { only_integer: true }
  validates :price, numericality: { greater_than_or_equal_to: 0}
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
