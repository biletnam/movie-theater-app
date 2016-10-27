class Theater < ApplicationRecord
  has_many :auditoria
  
  validates :name, :manager, :street_address, :city, :state, :zip, presence: true

  def full_address
    "#{street_address} \n#{city}, #{state} #{zip}"
  end
end
