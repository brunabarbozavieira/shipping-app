class PriceByDistance < ApplicationRecord
  validates :minimum_distance, :maximum_distance, :rate, presence: true
end
