class MovieScreening < ApplicationRecord
  belongs_to :movie

  validates :movie_id, :start_time, presence: true
  validates :movie_id, numericality: { only_integer: true }

  def friendly_start_time
    start_time.strftime("%l:%M %p")
  end
end
