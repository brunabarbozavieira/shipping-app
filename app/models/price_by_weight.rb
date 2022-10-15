class PriceByWeight < ApplicationRecord
  validates :minimum_weight, :maximum_weight, :price_per_kilometer, presence: true
  belongs_to :shipping_method
end
