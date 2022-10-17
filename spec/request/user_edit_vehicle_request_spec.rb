require 'rails_helper'

describe 'Usuário edita um veículo', type: :request do 
   it 'sem estar autenticado' do 
   vehicle = Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650)

    patch(vehicle_path(vehicle.id), params: {vehicle: {brand: 'Honda'}})

    expect(response).to redirect_to new_user_session_url
  end
end 