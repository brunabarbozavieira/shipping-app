class ShippingMethodsController < ApplicationController
  def index
    @shipping_methods = ShippingMethod.all
  end

  def new
    @shipping_method = ShippingMethod.new
  end

  def create
    @shipping_method = ShippingMethod.new(params.require(:shipping_method).permit(:name, :minimum_distance, :maximum_distance, :minimum_weight, :maximum_weight, :flat_rate))
    if @shipping_method.save
      redirect_to @shipping_method, notice: 'Modalidade de frete cadastrada com sucesso.'
    else
      flash[:alert] = 'Modalidade de frete não cadastrada.'
      render 'new'
    end
  end

  def show
    @shipping_method = ShippingMethod.find(params[:id])
  end

  def edit
    @shipping_method = ShippingMethod.find(params[:id])
  end

  def update
    @shipping_method = ShippingMethod.new(params.require(:shipping_method).permit(:name, :minimum_distance, :maximum_distance, :minimum_weight, :maximum_weight, :flat_rate))
    if @shipping_method.save
      redirect_to @shipping_method, notice: 'Modalidade de frete atualizada com sucesso.'
    else
      flash[:alert] = 'Modalidade de frete não atualizada.'
      render 'edit'
    end
  end
end