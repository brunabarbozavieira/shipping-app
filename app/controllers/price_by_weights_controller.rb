class PriceByWeightsController < ApplicationController
  before_action :set_price_by_weight, only: [:edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :index]
  before_action :authenticate_user_is_admin?, only: [:new, :create, :edit, :update]

  def index
    @price_by_weights = PriceByWeight.all
  end

  def new 
    @price_by_weight = PriceByWeight.new
    @shipping_methods = ShippingMethod.all
  end

  def create 
    @price_by_weight = PriceByWeight.new(price_by_weight_params)
    if @price_by_weight.save
      redirect_to price_by_weights_url, notice: 'Preço por peso cadastrado com sucesso.'
    else
      @shipping_methods = ShippingMethod.all
      flash[:alert] = 'Preço por peso não cadastrado.'
      render 'new'
    end
  end

  def edit
    @shipping_methods = ShippingMethod.all
  end

  def update
    if @price_by_weight.update(price_by_weight_params)
      redirect_to price_by_weights_url, notice: 'Preço por peso atualizado com sucesso.'
    else
      @shipping_methods = ShippingMethod.all
      flash[:alert] = 'Preço por peso não foi atualizado.'
      render 'edit'
    end
  end

  private
  def set_price_by_weight
    @price_by_weight = PriceByWeight.find(params[:id])
  end

  def price_by_weight_params
    params.require(:price_by_weight).permit(:minimum_weight, :maximum_weight, :price_per_kilometer, :shipping_method_id)
  end
end