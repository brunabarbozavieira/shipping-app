class ServiceOrder < ApplicationRecord
  validates :initial_full_address , :product_code , :dimensions , :weight , :recipient_name , :identification_document , :contact_phone , :email , :full_delivery_address, :total_distance, :service_order_code, :status, presence: true
  enum status: { pending: 0, started: 5, closed: 9 }
  belongs_to :shipping_method, optional: true

  before_validation :generate_service_order_code, on: :create

  def options_shipping_method
    @shipping_methods = ShippingMethod.active
    @shipping_methods_options = []
    @shipping_methods.each do |sm|
      if self.total_distance > sm.minimum_distance && self.total_distance < sm.maximum_distance
        if self.weight > sm.minimum_weight && self.weight < sm.maximum_weight
          @shipping_methods_options << sm
        end
      end
    end
    @shipping_methods_options
  end

  def due_date(shipping_method)
      shipping_method.delivery_times.each do |delivery_times|
        if self.total_distance > delivery_times.minimum_distance && self.total_distance < delivery_times.maximum_distance
          return delivery_times.deadline_in_hours
        end
      end
  end

  def price_by_weight_for_each_shipping_method_options(shipping_method)
      shipping_method.price_by_weight.each do |price_by_weight|
        if self.weight > price_by_weight.minimum_weight && self.weight < price_by_weight.maximum_weight
         return self.total_distance * price_by_weight.price_per_kilometer
        end
      end
  end

  def price_by_distance_for_each_shipping_method_options(shipping_method)
      shipping_method.price_by_distance.each do |price_by_distance|
        if self.total_distance > price_by_distance.minimum_distance && self.total_distance < price_by_distance.maximum_distance
          return price_by_distance.rate
        end
      end
  end

  def total_price_service_order(shipping_method)
    shipping_method.flat_rate + price_by_weight_for_each_shipping_method_options(shipping_method) + price_by_distance_for_each_shipping_method_options(shipping_method)
  end

  private
  
  def generate_service_order_code
    self.service_order_code = SecureRandom.alphanumeric(15).upcase
  end

  
 
end
