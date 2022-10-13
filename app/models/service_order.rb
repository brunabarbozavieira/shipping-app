class ServiceOrder < ApplicationRecord
  validates :initial_full_address , :product_code , :dimensions , :weight , :recipient_name , :identification_document , :contact_phone , :email , :full_delivery_address, :total_distance, :service_order_code, :status, presence: true
  enum status: { pending: 0, started: 5, closed: 9 }

  before_validation :generate_service_order_code, on: :create

  private
  
  def generate_service_order_code
    self.service_order_code = SecureRandom.alphanumeric(15).upcase
  end
end
