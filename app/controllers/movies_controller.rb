class MoviesController < ApplicationController
  before_action :set_theater
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  
  def index
    @movies = @theater.movies
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      flash[:success] = "New movie successfully added!"
      redirect_to theater_movie_path(@theater, @movie)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      flash[:success] = "Movie was successfully updated!"
      redirect_to theater_movie_path(@theater, @movie)
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy

    if @movie.destroy
      redirect_to theater_movies_path(@theater)
    else
      flash[:warning] = "Unable to delete the movie"
      redirect_to theater_movie_path(@theater, @movie)
    end
  end

  private

    def set_theater
      @theater = Theater.find(params[:theater_id])
    end

    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(
        :auditorium_id,
        :theater_id,
        :title,
        :run_time_minutes,
        :ticket_price
      )
    end
end
