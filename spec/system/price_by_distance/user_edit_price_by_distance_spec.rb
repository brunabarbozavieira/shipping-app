require 'rails_helper'

describe 'Usuário edita preço por distância' do 
  it 'a partir da tela de listagem' do
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9)

    visit root_path
    click_on 'Preço por Distância'
    click_on 'Editar'

    expect(page).to have_content 'Editar Preço por Distância'
    expect(page).to have_field 'Distância Mínima', with: '0'
    expect(page).to have_field 'Distância Máxima', with:'50'
    expect(page).to have_field 'Taxa', with:'9.0'
  end

  it 'com sucesso' do 
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9)

    visit root_path
    click_on 'Preço por Distância'
    click_on 'Editar'
    fill_in 'Distância Mínima', with: '0'
    fill_in 'Distância Máxima', with: '50'
    fill_in 'Taxa', with: '9'
    click_on 'Salvar'

    expect(current_url).to eq price_by_distances_url
    expect(page).to have_content 'Preço por distância atualizado com sucesso.'
    expect(page).to have_content 'Tabela de Preço por Distância'
    expect(page).to have_content '0'
    expect(page).to have_content '50'
    expect(page).to have_content '9'
  end

  it 'com informações incompletas' do 
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9)

    visit root_path
    click_on 'Preço por Distância'
    click_on 'Editar'
    fill_in 'Distância Mínima', with: ''
    fill_in 'Distância Máxima', with: ''
    fill_in 'Taxa', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Preço por distância não foi atualizado.'
    expect(page).to have_content 'Distância Mínima não pode ficar em branco'
    expect(page).to have_content 'Distância Máxima não pode ficar em branco'
    expect(page).to have_content 'Taxa não pode ficar em branco'
  end
end