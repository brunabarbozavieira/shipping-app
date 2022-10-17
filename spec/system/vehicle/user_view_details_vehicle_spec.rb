require 'rails_helper'

describe 'Usuário vê detalhes do veículo' do
  it 'a partir da listagem de veículos' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')
    Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650)
    Vehicle.create!(license_plate:'KQV6B36', brand:'Renault', model: 'Kangoo', year_of_manufacture: 2020, maximum_load_capacity: 800)

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