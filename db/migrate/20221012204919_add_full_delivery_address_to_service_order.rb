class AddFullDeliveryAddressToServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :service_orders, :full_delivery_address, :string
  end
end
