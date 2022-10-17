class DeliveryTimesController < ApplicationController
  before_action :set_delivery_time, only: [:edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :index]
  before_action :authenticate_user_is_admin?, only: [:new, :create, :edit, :update]

  def index
    @delivery_times = DeliveryTime.all
  end

  def new
    @delivery_time = DeliveryTime.new
    @shipping_methods = ShippingMethod.all
  end
  
  def create 
    @delivery_time = DeliveryTime.new(delivery_time_params)
    if @delivery_time.save
      redirect_to delivery_times_url, notice: 'Prazo de entrega cadastrado com sucesso.'
    else
      @shipping_methods = ShippingMethod.all
      flash[:alert] = 'Prazo de entrega não cadastrado.'
      render 'new'
    end
  end

  def edit 
    @shipping_methods = ShippingMethod.all
  end

  def update
    if @delivery_time.update(delivery_time_params)
      redirect_to delivery_times_url, notice: 'Prazo de entrega atualizado com sucesso.'
    else
      @shipping_methods = ShippingMethod.all
      flash[:alert] = 'Prazo de entrega não foi atualizado.'
      render 'edit'
    end
  end

  private
  def set_delivery_time
    @delivery_time = DeliveryTime.find(params[:id])
  end

  def delivery_time_params
    params.require(:delivery_time).permit(:minimum_distance, :maximum_distance, :deadline_in_hours, :shipping_method_id)
  end
end