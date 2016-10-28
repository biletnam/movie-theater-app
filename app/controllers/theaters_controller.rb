class TheatersController < ApplicationController
  before_action :set_theater, only: [:show, :edit, :update, :destroy]
  
  def index
    @theaters = Theater.all
  end

  def new
    @theater = Theater.new
  end

  def create
    @theater = Theater.new(theater_params)

    if @theater.save
      flash[:success] = "New theater successfully created!"
      redirect_to theater_path(@theater)
    else
      render :new
    end
  end

  def show
    @auditoriums = @theater.auditoria
    @movies = @theater.movies
  end

  def edit
  end

  def update
    if @theater.update(theater_params)
      flash[:success] = "Theater was successfully updated!"
      redirect_to theater_path(@theater)
    else
      render :edit
    end
  end

  def destroy
    if @theater.destroy
      flash[:success] = "Theater was successfully deleted!"
      redirect_to theaters_path
    else
      flash[:warning] = "Unable to delete the theater"
      redirect_to theater_path(@theater)
    end
  end

  private

    def set_theater
      @theater = Theater.find(params[:id])
    end

    def theater_params
      params.require(:theater).permit(
        :name,
        :manager,
        :street_address,
        :city,
        :state,
        :zip
      )
    end
end
