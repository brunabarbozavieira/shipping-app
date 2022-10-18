class AddShippingMethodToVehicle < ActiveRecord::Migration[7.0]
  def change
    add_reference :vehicles, :shipping_method, null: false, foreign_key: true
  end
end
