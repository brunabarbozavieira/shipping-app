class DeliveryTime < ApplicationRecord
  validates :minimum_distance, :maximum_distance, :deadline_in_hours, presence: true
end
