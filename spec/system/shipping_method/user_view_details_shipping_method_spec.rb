require 'rails_helper'

describe 'Usuário vê detalhes de uma modalidade de frete' do 
  it 'a partir da tela inicial' do 
    ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

    login_as regular
    visit root_path
    click_on 'Modalidades de Frete'
    click_on 'Super Veloz'

    expect(page).to have_content 'Super Veloz'
    expect(page).to have_content 'Distância Mínima: 0 km'
    expect(page).to have_content 'Distância Máxima: 4 km'
    expect(page).to have_content 'Peso Mínimo: 0 kg'
    expect(page).to have_content 'Peso Máximo: 20 kg'
    expect(page).to have_content 'Taxa Fixa: R$ 6,00'
    expect(page).to have_content 'Status: Ativa'
  end
end