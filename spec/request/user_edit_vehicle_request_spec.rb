require 'rails_helper'

describe 'Usuário edita um veículo', type: :request do 
    it 'sem estar autenticado' do 
      shipping_method = ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
      vehicle = Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method)

    patch(vehicle_path(vehicle.id), params: {vehicle: {brand: 'Honda'}})

    expect(response).to redirect_to new_user_session_url
  end

  it 'e não é o usuário administrador' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')
    shipping_method = ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    vehicle = Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method)

    login_as regular
    patch(vehicle_path(vehicle.id), params: {vehicle: {brand: 'Honda'}})

    expect(response).to redirect_to root_path
  end
end 