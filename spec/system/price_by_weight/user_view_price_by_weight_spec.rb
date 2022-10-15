require 'rails_helper'

describe 'Usuário vê tabela de preço por peso' do 
  it 'a partir da tela inicial' do 
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5, shipping_method: shipping_method)
    PriceByWeight.create!(minimum_weight: 11, maximum_weight: 30, price_per_kilometer: 0.8, shipping_method: shipping_method)
  
    visit root_path
    click_on 'Preços por Peso'
    
    expect(current_url).to eq price_by_weights_url
    expect(page).to have_content 'Tabela de Preço por Peso'
    expect(page).to have_content '0'
    expect(page).to have_content '10'
    expect(page).to have_content '11'
    expect(page).to have_content '30'
    expect(page).to have_content '0.5'
    expect(page).to have_content '0.8'
    expect(page).to have_content 'Peso Mínimo'
    expect(page).to have_content 'Peso Máximo'
    expect(page).to have_content 'Preço por km'
    expect(page).to have_content 'Modalidade de Frete'
    expect(page).to have_content 'Super Veloz'


  end

  it 'e não existem cadastros de preços por pesos' do 
    visit root_path
    click_on 'Preços por Peso'

    expect(page).to have_content 'Não existem cadastros de preço por peso.'
  end
end