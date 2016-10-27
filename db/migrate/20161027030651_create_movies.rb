class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.integer :theater_id
      t.integer :auditorium_id
      t.string :title
      t.integer :run_time_minutes

      t.timestamps
    end
    add_index :movies, :theater_id
    add_index :movies, :auditorium_id
  end
end
