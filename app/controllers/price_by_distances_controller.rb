class PriceByDistancesController < ApplicationController
  def index
    @price_by_distances = PriceByDistance.all
  end

  def new
    @price_by_distance = PriceByDistance.new
  end

  def create
    @price_by_distance = PriceByDistance.new(params.require(:price_by_distance).permit(:minimum_distance, :maximum_distance, :rate))
    if @price_by_distance.save
      redirect_to price_by_distances_url, notice: 'Preço por distância cadastrado com sucesso.'
    else
      flash[:alert] = 'Preço por distância não cadastrado.'
      render 'new'
    end
  end

  def edit
    @price_by_distance = PriceByDistance.find(params[:id])
  end

  def update
    @price_by_distance = PriceByDistance.new(params.require(:price_by_distance).permit(:minimum_distance, :maximum_distance, :rate))
    if @price_by_distance.save
      redirect_to price_by_distances_url, notice: 'Preço por distância atualizado com sucesso.'
    else
      flash[:alert] = 'Preço por distância não foi atualizado.'
      render 'new'
    end
  end
end