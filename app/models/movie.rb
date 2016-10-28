class Movie < ApplicationRecord
  belongs_to :auditorium
  belongs_to :theater
  has_many :movie_screenings, dependent: :destroy

  validates :theater_id, :auditorium_id, :title, :run_time_minutes, :ticket_price, presence: true
  validates :theater_id, :auditorium_id, :run_time_minutes, numericality: { only_integer: true }
  validates :ticket_price, numericality: { greater_than_or_equal_to: 0}

  def run_time_hours
    hours = run_time_minutes / 60
    minutes = run_time_minutes % 60

    if hours > 1 && minutes > 1
      run_time = "#{hours} hours #{minutes} minutes"
    elsif hours > 1 && minutes == 1
      run_time = "#{hours} hours #{minutes} minute"
    elsif hours > 1 && minutes == 0
      run_time = "#{hours} hours"
    elsif hours == 1 && minutes == 0
      run_time = "#{hours} hour"
    elsif hours == 1 && minutes > 1
       run_time ="#{hours} hour #{minutes} minutes"
    elsif hours == 1 && minutes == 1
       run_time ="#{hour} hour #{minutes} minute"
    elsif hours == 0 && minutes > 1
       run_time ="#{minutes} minutes"
    elsif hours == 0 && minutes == 1
       run_time ="#{minutes} minute"    
    end
    run_time
  end
end
