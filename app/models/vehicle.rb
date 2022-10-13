class Vehicle < ApplicationRecord
  validates :license_plate, :brand, :model, :year_of_manufacture, :maximum_load_capacity, presence: true
  validates :license_plate, uniqueness: true
  validates :license_plate, length: { is: 7 }

  enum status: {available: 0, operation: 5, maintenance: 9}
end
