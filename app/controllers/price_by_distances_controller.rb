class PriceByDistancesController < ApplicationController
  before_action :set_price_by_distance, only: [:edit, :update]

  def index
    @price_by_distances = PriceByDistance.all
  end

  def new
    @price_by_distance = PriceByDistance.new
  end

  def create
    @price_by_distance = PriceByDistance.new(price_by_distance_params)
    if @price_by_distance.save
      redirect_to price_by_distances_url, notice: 'Preço por distância cadastrado com sucesso.'
    else
      flash[:alert] = 'Preço por distância não cadastrado.'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @price_by_distance.update(price_by_distance_params)
      redirect_to price_by_distances_url, notice: 'Preço por distância atualizado com sucesso.'
    else
      flash[:alert] = 'Preço por distância não foi atualizado.'
      render 'edit'
    end
  end

  private
  def set_price_by_distance
    @price_by_distance = PriceByDistance.find(params[:id])
  end

  def price_by_distance_params
    params.require(:price_by_distance).permit(:minimum_distance, :maximum_distance, :rate)
  end
end