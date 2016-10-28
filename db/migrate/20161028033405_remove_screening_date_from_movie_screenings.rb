class RemoveScreeningDateFromMovieScreenings < ActiveRecord::Migration[5.0]
  def change
    remove_column :movie_screenings, :screening_date, :date
  end
end
