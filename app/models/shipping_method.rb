class ShippingMethod < ApplicationRecord
  validates :name, :minimum_distance, :maximum_distance, :minimum_weight, :maximum_weight, :flat_rate, presence: true
  has_many :price_by_distance
  has_many :price_by_weight
  has_many :delivery_times

  enum status: { active: 0, disabled: 5 }

end
