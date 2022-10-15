class AddShippingMethodToPriceByWeight < ActiveRecord::Migration[7.0]
  def change
    add_reference :price_by_weights, :shipping_method, null: false, foreign_key: true
  end
end
