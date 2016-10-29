class TicketOrder < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :movie_screening

  validates :movie_screening_id, :price, :ticket_date, :name, :email, :expiration_date, presence: true
  validate :current_ticket_date, on: :create
  validates :credit_card_number, presence: true, credit_card_number: true
  validate :expiration_date_cannot_be_in_the_past
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

  def order_date
    created_at.strftime("%b %e, %Y - %I:%M %p")
  end

  def self.order_date_asc
    order(created_at: :asc)
  end

  def self.order_date_desc
    order(created_at: :desc)
  end

  def current_ticket_date
    if ticket_date.present? && ticket_date < Date.today
      errors.add(:ticket_date, "is in the past and no longer available for purchase")
    end
  end  

  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date < Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end
end
