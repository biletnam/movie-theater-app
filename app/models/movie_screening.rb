class MovieScreening < ApplicationRecord
  belongs_to :movie

  validates :movie_id, :screening_date, :start_time, presence: true
  validates :movie_id, numericality: { only_integer: true }
end
