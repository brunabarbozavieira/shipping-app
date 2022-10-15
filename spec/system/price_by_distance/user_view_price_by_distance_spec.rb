require 'rails_helper'

describe 'Usuário vê tabela de preço por distâcia' do 
  it 'a partir da tela inicial' do 
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method)
    PriceByDistance.create!(minimum_distance: 51, maximum_distance: 150, rate: 12, shipping_method: shipping_method)
  
    visit root_path
    click_on 'Preços por Distância'
    
    expect(current_url).to eq price_by_distances_url
    expect(page).to have_content 'Tabela de Preço por Distância'
    expect(page).to have_content '0'
    expect(page).to have_content '50'
    expect(page).to have_content '51'
    expect(page).to have_content '150'
    expect(page).to have_content '9'
    expect(page).to have_content '12'
    expect(page).to have_content 'Distância Mínima'
    expect(page).to have_content 'Distância Máxima'
    expect(page).to have_content 'Taxa'
    expect(page).to have_content 'Modalidade de Frete'
    expect(page).to have_content 'Super Veloz'

  end

  it 'e não existem cadastros de preços por distância' do 
    visit root_path
    click_on 'Preços por Distância'

    expect(page).to have_content 'Não existem cadastros de preço por distância.'
  end
end