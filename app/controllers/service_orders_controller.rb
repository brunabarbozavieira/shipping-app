class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index, :show, :start_service_order, :filter]
  before_action :authenticate_user_is_admin?, only: [:new, :create]
  def index
    @service_orders = ServiceOrder.all
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

  def filter
    @service_orders = ServiceOrder.where(status: params[:status])
    render 'index'
  end

  def search
    @service_order_code = params["query"]
    @service_order = ServiceOrder.find_by(service_order_code: @service_order_code)
    if @service_order.nil?
      redirect_to root_path, alert: 'Código de rastreio inválido.'
    end
  end
  
  def start_service_order
    @service_order = ServiceOrder.find(params[:service_order_id])
    @shipping_method = ShippingMethod.find(params[:shipping_method_id])
    @vehicle = Vehicle.available.where(shipping_method: @shipping_method).first
    @service_order.vehicle = @vehicle
    @service_order.start_date = DateTime.now
    @service_order.deadline = @service_order.due_date(@shipping_method)
    @service_order.total_delivery_value = @service_order.total_price_service_order(@shipping_method)
    @service_order.shipping_method = @shipping_method
    @service_order.started!
    @vehicle.operation!
    @service_order.save
    redirect_to @service_order, notice: 'Ordem de serviço iniciada com sucesso.'
  end

  def closed_service_order
    @service_order = ServiceOrder.find(params[:service_order_id])
    @service_order.reason_for_delay = params[:reason_for_delay]
    @service_order.delivery_date = DateTime.now
    @service_order.status = 'closed'
    @vehicle = Vehicle.find(@service_order.vehicle_id)
    @vehicle.available!
    if @service_order.save
      redirect_to @service_order, notice: 'Ordem de serviço encerrada com sucesso.'
    else
      flash[:notice] = 'Ordem de serviço não pode ser encerrada./'
      redirect_to @service_order, flash: { alert: @service_order.errors.full_messages.join(', ') }
    end
  end
  
end