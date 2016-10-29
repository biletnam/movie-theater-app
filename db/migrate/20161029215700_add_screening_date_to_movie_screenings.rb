class AddScreeningDateToMovieScreenings < ActiveRecord::Migration[5.0]
  def change
    add_column :movie_screenings, :screening_date, :date
  end
end
