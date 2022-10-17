class ShippingMethodsController < ApplicationController
  before_action :set_shipping_method, only: [:edit, :update, :show, :disabled, :active]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :disabled, :active]
  before_action :authenticate_user_is_admin?, only: [:new, :create, :edit, :update, :disabled, :active]
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
  end

  def edit
  end

  def update
    if @shipping_method.update(shipping_method_params)
      redirect_to @shipping_method, notice: 'Modalidade de frete atualizada com sucesso.'
    else
      flash[:alert] = 'Modalidade de frete não atualizada.'
      render 'edit'
    end
  end

  def active
    @shipping_method.active!
    redirect_to @shipping_method
  end

  def disabled
    @shipping_method.disabled!
    redirect_to @shipping_method
  end

  private

  def set_shipping_method
    @shipping_method = ShippingMethod.find(params[:id])
  end

  def shipping_method_params
    params.require(:shipping_method).permit(:name, :minimum_distance, :maximum_distance, :minimum_weight, :maximum_weight, :flat_rate)
  end
end