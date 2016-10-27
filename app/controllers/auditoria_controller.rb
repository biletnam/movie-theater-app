class AuditoriaController < ApplicationController
  before_action :set_theater, except: [:update]
  before_action :set_auditorium, only: [:show, :edit, :update, :destroy]
  
  def index
    @auditoriums = @theater.auditoria
  end

  def new
    @auditorium = Auditorium.new
  end

  def create
    @auditorium = Auditorium.new(auditorium_params)

    if @auditorium.save
      flash[:success] = "New auditorium successfully created!"
      redirect_to theater_auditorium_path(@theater, @auditorium)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @auditorium.update(auditorium_params)
      @theater = @auditorium.theater
      flash[:success] = "Auditorium was successfully updated!"
      redirect_to theater_auditorium_path(@theater, @auditorium)
    else
      render :edit
    end
  end

  def destroy
    @auditorium.destroy
    redirect_to theater_auditoria_path(@theater)
  end

  private

    def set_theater
      @theater = Theater.find(params[:theater_id])
    end

    def set_auditorium
      @auditorium = Auditorium.find(params[:id])
    end

    def auditorium_params
      params.require(:auditorium).permit(
        :theater_id,
        :name,
        :seating_capacity
      )
    end
end
