class DeliveryTime < ApplicationRecord
  validates :minimum_distance, :maximum_distance, :deadline_in_hours, presence: true
  belongs_to :shipping_method
end
