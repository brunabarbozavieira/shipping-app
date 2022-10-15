require 'rails_helper'

describe 'Usuário cadastra novo preço por distância' do 
  it 'a partir da tela de listagem' do
    visit root_path
    click_on 'Preços por Distância'
    click_on 'Cadastrar novo preço por distância'

    expect(page).to have_field 'Distância Mínima'
    expect(page).to have_field 'Distância Máxima'
    expect(page).to have_field 'Taxa'
    expect(page).to have_field 'Modalidade de Frete'
    expect(page).to have_button 'Salvar'
  end

  it 'com sucesso' do 
    ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    ShippingMethod.create!(name: 'Itens Grandes', minimum_distance: 0, maximum_distance: 2, minimum_weight: 50, maximum_weight: 500, flat_rate: 32)

    visit root_path
    click_on 'Preços por Distância'
    click_on 'Cadastrar novo preço por distância'
    fill_in 'Distância Mínima', with: '0'
    fill_in 'Distância Máxima', with: '50'
    fill_in 'Taxa', with: '9'
    select 'Super Veloz', from: 'Modalidade de Frete'
    click_on 'Salvar'

    expect(current_url).to eq price_by_distances_url
    expect(page).to have_content 'Preço por distância cadastrado com sucesso.'
    expect(page).to have_content 'Tabela de Preço por Distância'
    expect(page).to have_content '0'
    expect(page).to have_content '50'
    expect(page).to have_content '9'
    expect(page).to have_content 'Super Veloz'
  end

  it 'com informações incompletas' do
    ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
     
    visit root_path
    click_on 'Preços por Distância'
    click_on 'Cadastrar novo preço por distância'
    fill_in 'Distância Mínima', with: ''
    fill_in 'Distância Máxima', with: ''
    fill_in 'Taxa', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Preço por distância não cadastrado.'
    expect(page).to have_content 'Distância Mínima não pode ficar em branco'
    expect(page).to have_content 'Distância Máxima não pode ficar em branco'
    expect(page).to have_content 'Taxa não pode ficar em branco'
  end
end