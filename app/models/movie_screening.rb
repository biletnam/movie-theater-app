class MovieScreening < ApplicationRecord
  belongs_to :movie
  belongs_to :theater
  has_many :ticket_orders, dependent: :destroy

  validates :movie_id, :theater_id, :screening_date, :start_time, presence: true
  validates :movie_id, :theater_id, numericality: { only_integer: true }

  scope :current_ordered_screenings, -> { where('screening_date >= ?', Date.today).order(:screening_date)}

  def friendly_start_time
    start_time.strftime("%l:%M %p")
  end

  def friendly_screening_date
    screening_date.strftime("%b %e, %Y")
  end

  def short_screening_date
    screening_date.strftime("%m/%d/%Y")
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

  # def self.current_ordered_screenings
  #   where(screening_date: Date.today)
  # end
end
