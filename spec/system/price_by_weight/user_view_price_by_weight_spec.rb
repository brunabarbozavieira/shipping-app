require 'rails_helper'

describe 'Usuário vê tabela de preço por peso' do 
  it 'a partir da tela inicial' do 
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5)
    PriceByWeight.create!(minimum_weight: 11, maximum_weight: 30, price_per_kilometer: 0.8)
  
    visit root_path
    click_on 'Preço por Peso'
    
    expect(current_url).to eq price_by_weights_url
    expect(page).to have_content 'Tabela de Preço por Peso'
    expect(page).to have_content '0'
    expect(page).to have_content '10'
    expect(page).to have_content '11'
    expect(page).to have_content '30'
    expect(page).to have_content '0.5'
    expect(page).to have_content '0.8'
  end

  it 'e não existem cadastros de preços por pesos' do 
    visit root_path
    click_on 'Preço por Peso'

    expect(page).to have_content 'Não existem cadastros de preço por peso.'
  end
end