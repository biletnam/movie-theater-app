class CreateMovieScreenings < ActiveRecord::Migration[5.0]
  def change
    create_table :movie_screenings do |t|
      t.integer :movie_id
      t.date :screening_date
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
    add_index :movie_screenings, :movie_id
  end
end
