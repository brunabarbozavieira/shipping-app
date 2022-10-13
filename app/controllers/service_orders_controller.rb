class ServiceOrdersController < ApplicationController
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
end