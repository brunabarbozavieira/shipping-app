require 'rails_helper'

describe 'Usuário vê detalhes do veículo' do
  it 'a partir da listagem de veículos' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')
    shipping_method = ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method)
    Vehicle.create!(license_plate:'KQV6B36', brand:'Renault', model: 'Kangoo', year_of_manufacture: 2020, maximum_load_capacity: 800, shipping_method: shipping_method)

    login_as regular
    visit root_path
    click_on 'Veículos'
    click_on 'MRO4H51'

    expect(page).to have_content 'Placa: MRO4H51'
    expect(page).to have_content 'Marca: Fiat'
    expect(page).to have_content 'Ano de Fabricação: 2019'
    expect(page).to have_content 'Capacidade Máxima de Carga: 650 kg'
    expect(page).to have_content 'Status: Disponível'
  end
end