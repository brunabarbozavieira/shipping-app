class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_user_is_admin?, only: [:new, :create]
  def index
    @service_orders = ServiceOrder.pending
  end

  def new 
    @service_order = ServiceOrder.new
  end

  def create
    @service_order = ServiceOrder.new(params.require(:service_order).permit(:initial_full_address , :product_code , :dimensions , :weight , :recipient_name , :identification_document , :contact_phone , :email , :full_delivery_address, :total_distance))
    if @service_order.save
     redirect_to @service_order
    else
      flash[:alert] = 'Ordem de serviço não cadastrada.'
      render 'new'
    end
  end

  def show
    @service_order = ServiceOrder.find(params[:id])
  end
  
  def start_service_order
    @service_order = ServiceOrder.find(params[:service_order_id])
    @shipping_method = ShippingMethod.find(params[:shipping_method_id])
    @service_order.deadline = @service_order.due_date(@shipping_method)
    @service_order.total_delivery_value = @service_order.total_price_service_order(@shipping_method)
    @service_order.shipping_method = @shipping_method
    @service_order.started!
    @service_order.save
    redirect_to @service_order, notice: 'Ordem de serviço iniciada com sucesso.'
  end
  
end