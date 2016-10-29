class Theater < ApplicationRecord
  has_many :auditoria, dependent: :destroy
  has_many :movies, dependent: :destroy
  has_many :movie_screenings, dependent: :destroy
  has_many :ticket_orders, through: :movie_screenings, dependent: :destroy
  
  validates :name, :manager, :street_address, :city, :state, :zip, presence: true

  def full_address
    "#{street_address} \n#{city}, #{state} #{zip}"
  end
end
