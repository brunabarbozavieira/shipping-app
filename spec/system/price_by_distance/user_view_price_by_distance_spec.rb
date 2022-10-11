require 'rails_helper'

describe 'Usuário vê tabela de preço por distâcia' do 
  it 'a partir da tela inicial' do 
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9)
    PriceByDistance.create!(minimum_distance: 51, maximum_distance: 150, rate: 12)
  
    visit root_path
    click_on 'Preço por Distância'
    
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
  end

  it 'e não existem cadastros de preços por distância' do 
    visit root_path
    click_on 'Preço por Distância'

    expect(page).to have_content 'Não existem cadastros de preço por distância.'
  end
end