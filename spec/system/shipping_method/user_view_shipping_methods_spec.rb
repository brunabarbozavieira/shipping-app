require 'rails_helper'

describe 'Usuário vê lista de modalidades de frete' do 
  it 'a partir da tela inicial' do 
    ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    ShippingMethod.create!(name: 'itens Grandes', minimum_distance: 0, maximum_distance: 2, minimum_weight: 50, maximum_weight: 500, flat_rate: 32)

    visit root_path
    click_on 'Modalidades de Frete'

    expect(page).to have_content 'Super veloz'
    expect(page).to have_content 'itens Grandes'
    expect(page).to have_content 'R$ 6'
    expect(page).to have_content 'R$ 32'
  end

  it 'e não existem modalidades de frete cadastradas' do
    visit root_path
    click_on 'Modalidades de Frete'

    expect(page).to have_content 'Não existem modalidades de frete cadastradas.'
    expect(page).not_to have_content 'Nome'
    expect(page).not_to have_content 'Taxa Fixa'
  end
end
