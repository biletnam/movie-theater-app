class MovieScreening < ApplicationRecord
  belongs_to :movie
  has_many :ticket_orders, dependent: :destroy

  validates :movie_id, :start_time, presence: true
  validates :movie_id, numericality: { only_integer: true }

  def friendly_start_time
    start_time.strftime("%l:%M %p")
  end

  def tickets_sold
    ticket_orders.count
  end

  def tickets_remaining
    unsold_tickets = movie.auditorium.seating_capacity - tickets_sold
  end

  def sold_out?
    !(tickets_remaining > 0)
  end

  def disable_screening
    if sold_out?
      "disabled"
    end
  end
end
