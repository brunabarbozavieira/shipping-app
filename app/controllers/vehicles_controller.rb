class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end

  def show 
    @vehicle = Vehicle.find(params[:id])
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(params.require(:vehicle).permit(:license_plate, :brand, :model, :year_of_manufacture, :maximum_load_capacity))
    if @vehicle.save
      redirect_to @vehicle, notice: 'Veículo cadastrado com sucesso.'
    else
      flash[:notice] = 'Veículo não cadastrado.'
      render 'new'
    end
  end
end