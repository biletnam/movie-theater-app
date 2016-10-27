class Auditorium < ApplicationRecord
  belongs_to :theater
  has_many :movies
  
  validates :name, :theater_id, :seating_capacity, presence: true
  validates :theater_id, :seating_capacity, numericality: { only_integer: true }
end
