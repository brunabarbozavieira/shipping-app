class AddShippingMethodToDeliveryTime < ActiveRecord::Migration[7.0]
  def change
    add_reference :delivery_times, :shipping_method, null: false, foreign_key: true
  end
end
