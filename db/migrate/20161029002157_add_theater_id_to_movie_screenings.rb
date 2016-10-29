class AddTheaterIdToMovieScreenings < ActiveRecord::Migration[5.0]
  def change
    add_column :movie_screenings, :theater_id, :integer
    add_index :movie_screenings, :theater_id
  end
end
