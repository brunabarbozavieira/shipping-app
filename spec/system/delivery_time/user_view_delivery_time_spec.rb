require 'rails_helper'

describe 'Usuário vê prazos de entrega' do 
  it 'a partir da tela inicial' do 
    DeliveryTime.create!(minimum_distance:0, maximum_distance:100, deadline_in_hours: 48)
    DeliveryTime.create!(minimum_distance:101, maximum_distance:300, deadline_in_hours: 96)

    visit root_path
    click_on 'Prazos de Entrega'

    expect(current_url).to eq delivery_times_url
    expect(page).to have_content 'Tabela de Prazos de Entrega'
    expect(page).to have_content '48'
    expect(page).to have_content '96'
  end

  it 'e não existem prazos de entrega cadastrados' do 
    visit root_path
    click_on 'Prazos de Entrega'

    expect(current_url).to eq delivery_times_url
    expect(page).to have_content 'Não existem prazos de entrega cadastrados.'
  end
end