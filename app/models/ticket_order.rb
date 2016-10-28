class TicketOrder < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :movie_screening

  validates :movie_screening_id, :price, :name, :email, :expiration_date, presence: true
  validates :credit_card_number, presence: true, credit_card_number: true
  validates :movie_screening_id, numericality: { only_integer: true }
  validates :price, numericality: { greater_than_or_equal_to: 0}
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def cc_last_four_digits
    credit_card_number
  end

  def starred_cc_number
    card_number = credit_card_number
    card_number_array = card_number.split("")
    reversed_four_digits = ""
    
    4.times do 
      reversed_four_digits += card_number_array.pop
    end

    last_four_digits = reversed_four_digits.reverse
    starred_number = card_number_array.join.gsub(/\w/, "*")
    full_starred_number = starred_number + last_four_digits
  end

  def cc_expiration_date
    expiration_date.strftime("%m/%Y")
  end
end
