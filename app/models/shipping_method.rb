class ShippingMethod < ApplicationRecord
  validates :name, :minimum_distance, :maximum_distance, :minimum_weight, :maximum_weight, :flat_rate, presence: true

  enum status: { active: 0, disabled: 5 }
end
