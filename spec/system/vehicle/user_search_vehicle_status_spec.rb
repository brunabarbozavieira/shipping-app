require 'rails_helper'

describe 'Usuário busca veículo usando placa' do 
  it 'a partir da tela de listagem' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')
    
    login_as regular
    visit root_path
    click_on 'Veículos'

    expect(page).to have_field 'Buscar Veículos'
    expect(page).to have_button 'Buscar'
  end

  it 'e encontra um veículo' do
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')
    shipping_method = ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method)
    Vehicle.create!(license_plate:'MRV6B36', brand:'Renault', model: 'Kangoo', year_of_manufacture: 2020, maximum_load_capacity: 800, shipping_method: shipping_method)
  
    login_as regular
    visit root_path
    click_on 'Veículos'
    fill_in 'Buscar Veículos', with: 'MRO4H51'
    click_on 'Buscar'

    expect(page).to have_content 'Fiorino'
    expect(page).to have_content 'MRO4H51'
    expect(page).not_to have_content 'Kangoo'
    expect(page).not_to have_content 'KQV6B36'
  end

  it 'e encontra vários veículos' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')
    shipping_method = ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method)
    Vehicle.create!(license_plate:'MRV6B36', brand:'Renault', model: 'Kangoo', year_of_manufacture: 2020, maximum_load_capacity: 800, shipping_method: shipping_method)
  
    login_as regular
    visit root_path
    click_on 'Veículos'
    fill_in 'Buscar Veículos', with: 'MR'
    click_on 'Buscar'

    expect(page).to have_content 'Fiorino'
    expect(page).to have_content 'MRO4H51'
    expect(page).to have_content 'Kangoo'
    expect(page).to have_content 'MRV6B36'
  end
end