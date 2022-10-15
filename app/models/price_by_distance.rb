class PriceByDistance < ApplicationRecord
  validates :minimum_distance, :maximum_distance, :rate, presence: true
  belongs_to :shipping_method
end
