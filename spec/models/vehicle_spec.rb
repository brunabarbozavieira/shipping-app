require 'rails_helper'

RSpec.describe Vehicle, type: :model do
describe '#valid?' do 
  it 'placa é obrigatório' do 
    vehicle = Vehicle.new(license_plate: '')

    vehicle.valid?

    expect(vehicle.errors.include? :license_plate).to eq true 
  end

  it 'marca é obrigatório' do 
    vehicle = Vehicle.new(brand: '')

    vehicle.valid?

    expect(vehicle.errors.include? :brand).to eq true 
  end

  it 'modelo é obrigatório' do 
    vehicle = Vehicle.new(model: '')

    vehicle.valid?

    expect(vehicle.errors.include? :model).to eq true 
  end

  it 'ano de fabricação é obrigatório' do 
    vehicle = Vehicle.new(year_of_manufacture: '')

    vehicle.valid?

    expect(vehicle.errors.include? :year_of_manufacture).to eq true 
  end

  it 'capacidade máxima de carga é obrigatório' do 
    vehicle = Vehicle.new(maximum_load_capacity: '')

    vehicle.valid?

    expect(vehicle.errors.include? :maximum_load_capacity).to eq true 
  end

  it 'placa é unico' do 
    shipping_method = ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    first_vehicle = Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method)
    second_vehicle = Vehicle.new(license_plate:'MRO4H51', brand:'Renault', model: 'Kangoo', year_of_manufacture: 2020, maximum_load_capacity: 800, shipping_method: shipping_method)

    second_vehicle.valid?

    expect(second_vehicle.errors.include? :license_plate).to eq true 
  end

  it 'placa não pode ter mais que 7 caracteres' do 
    vehicle = Vehicle.new(license_plate: 'MRO4H510')

    vehicle.valid?

    expect(vehicle.errors.include? :license_plate).to eq true 
  end

  it 'placa não pode ter menos que 7 caracteres' do 
    vehicle = Vehicle.new(license_plate: 'MRO4H5')

    vehicle.valid?

    expect(vehicle.errors.include? :license_plate).to eq true 
  end

end
end
