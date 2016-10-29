class MovieScreeningsController < ApplicationController
  before_action :set_theater_and_movie
  before_action :set_movie_screening, only: [:show, :edit, :update, :destroy]
  
  def index
    @movie_screenings = @movie.movie_screenings
  end

  def new
    @movie_screening = MovieScreening.new
  end

  def create
    @movie_screening = MovieScreening.new(movie_screening_params)

    if @movie_screening.save
      flash[:success] = "New movie screening successfully added!"
      redirect_to movie_movie_screening_path(@movie, @movie_screening)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @movie_screening.update(movie_screening_params)
      flash[:success] = "Movie was successfully updated!"
      redirect_to movie_movie_screening_path(@movie, @movie_screening)
    else
      render :edit
    end
  end

  def destroy
    if @movie_screening.destroy
      flash[:success] = "Movie screening was successfully deleted!"
      redirect_to theater_path(@theater)
    else
      flash[:warning] = "Unable to delete the movie screening"
      redirect_to movie_movie_screening_path(@movie, @movie_screening)
    end
  end

  private

    def set_theater_and_movie
      @movie = Movie.find(params[:movie_id])
      @theater = @movie.theater
    end

    def set_movie_screening
      @movie_screening = MovieScreening.find(params[:id])
    end

    def movie_screening_params
      params.require(:movie_screening).permit(
        :movie_id,
        :theater_id,
        :screening_date,
        :start_time,
        :end_time
      )
    end
end
