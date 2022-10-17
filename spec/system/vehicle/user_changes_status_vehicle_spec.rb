require 'rails_helper'

describe 'Usuário coloca veículo em manutenção' do 
  it 'com sucesso' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')
    vehicle = Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650)

    login_as admin
    visit root_path
    click_on 'Veículos'
    click_on 'MRO4H51'
    click_on 'Veículo em Manutenção'

    expect(current_url).to eq vehicle_url(vehicle.id)
    expect(page).to have_content 'Placa: MRO4H51'
    expect(page).to have_content 'Status: Manutenção'
    expect(page).to have_button 'Veículo Disponível'
    expect(page).not_to have_button 'Veículo em Manutenção'
  end

  it 'e não é usuário administrador' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')
    vehicle = Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650)

    login_as regular
    visit root_path
    click_on 'Veículos'
    click_on 'MRO4H51'
    click_on 'Veículo em Manutenção'

    expect(current_url).to eq root_url
    expect(page).to have_content 'Usuário não possui autorização.'
  end
end

describe 'Usuário muda status do veículo para disponível' do 
  it 'com sucesso' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')
    vehicle = Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, status: 'maintenance')

    login_as admin
    visit root_path
    click_on 'Veículos'
    click_on 'MRO4H51'
    click_on 'Veículo Disponível'

    expect(current_url).to eq vehicle_url(vehicle.id)
    expect(page).to have_content 'Placa: MRO4H51'
    expect(page).to have_content 'Status: Disponível'
    expect(page).to have_button 'Veículo em Manutenção'
    expect(page).not_to have_button 'Veículo Disponível'
  end

  it 'e não é usuário administrador' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')
    vehicle = Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, status: 'maintenance')

    login_as regular
    visit root_path
    click_on 'Veículos'
    click_on 'MRO4H51'
    click_on 'Veículo Disponível'

    expect(current_url).to eq root_url
    expect(page).to have_content 'Usuário não possui autorização.'
  end
end