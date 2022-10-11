class PriceByWeightsController < ApplicationController
  def index
    @price_by_weights = PriceByWeight.all
  end

  def new 
    @price_by_weight = PriceByWeight.new
  end

  def create 
    @price_by_weight = PriceByWeight.new(params.require(:price_by_weight).permit(:minimum_weight, :maximum_weight,:price_per_kilometer))
    if @price_by_weight.save
      redirect_to price_by_weights_url, notice: 'Preço por peso cadastrado com sucesso.'
    else
      flash[:alert] = 'Preço por peso não cadastrado.'
      render 'new'
    end
  end

  def edit
    @price_by_weight = PriceByWeight.find(params[:id])
  end

  def update
    @price_by_weight = PriceByWeight.new(params.require(:price_by_weight).permit(:minimum_weight, :maximum_weight,:price_per_kilometer))
    if @price_by_weight.save
      redirect_to price_by_weights_url, notice: 'Preço por peso atualizado com sucesso.'
    else
      flash[:alert] = 'Preço por peso não foi atualizado.'
      render 'new'
    end
  end
end