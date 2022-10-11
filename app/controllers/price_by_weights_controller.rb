class PriceByWeightsController < ApplicationController
  before_action :set_price_by_weight, only: [:edit, :update]

  def index
    @price_by_weights = PriceByWeight.all
  end

  def new 
    @price_by_weight = PriceByWeight.new
  end

  def create 
    @price_by_weight = PriceByWeight.new(price_by_weight_params)
    if @price_by_weight.save
      redirect_to price_by_weights_url, notice: 'Preço por peso cadastrado com sucesso.'
    else
      flash[:alert] = 'Preço por peso não cadastrado.'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @price_by_weight.update(price_by_weight_params)
      redirect_to price_by_weights_url, notice: 'Preço por peso atualizado com sucesso.'
    else
      flash[:alert] = 'Preço por peso não foi atualizado.'
      render 'edit'
    end
  end

  private
  def set_price_by_weight
    @price_by_weight = PriceByWeight.find(params[:id])
  end

  def price_by_weight_params
    params.require(:price_by_weight).permit(:minimum_weight, :maximum_weight, :price_per_kilometer)
  end
end