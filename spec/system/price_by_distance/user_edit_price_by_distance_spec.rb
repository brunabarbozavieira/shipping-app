require 'rails_helper'

describe 'Usuário edita preço por distância' do 
  it 'se estiver autenticado como usuário administrador' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method)

    login_as admin
    visit root_path
    click_on 'Preços por Distância'
    click_on 'Editar'
    expect(current_url).to eq edit_price_by_distance_url(shipping_method.id)
  end

  it 'e não possui permissão' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method)

    login_as regular
    visit root_path
    click_on 'Preços por Distância'
    click_on 'Editar'

    expect(current_url).to eq root_url
    expect(page).to have_content 'Usuário não possui autorização.'
  end

  it 'a partir da tela de listagem' do
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method)
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Preços por Distância'
    click_on 'Editar'

    expect(page).to have_content 'Editar Preço por Distância'
    expect(page).to have_field 'Distância Mínima', with: '0'
    expect(page).to have_field 'Distância Máxima', with:'50'
    expect(page).to have_field 'Taxa', with:'9.0'
    expect(page).to have_field 'Modalidade de Frete'
  end

  it 'com sucesso' do 
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    ShippingMethod.create!(name: 'Itens Grandes', minimum_distance: 0, maximum_distance: 2, minimum_weight: 50, maximum_weight: 500, flat_rate: 32)
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method)
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Preços por Distância'
    click_on 'Editar'
    fill_in 'Distância Mínima', with: '100'
    fill_in 'Distância Máxima', with: '300'
    fill_in 'Taxa', with: '40'
    select 'Itens Grandes', from: 'Modalidade de Frete'
    click_on 'Salvar'

    expect(current_url).to eq price_by_distances_url
    expect(page).to have_content 'Preço por distância atualizado com sucesso.'
    expect(page).to have_content 'Tabela de Preço por Distância'
    expect(page).to have_content '100'
    expect(page).to have_content '300'
    expect(page).to have_content '40'
    expect(page).to have_content 'Itens Grandes'
    expect(page).not_to have_content '50'
    expect(page).not_to have_content '9'

  end

  it 'com informações incompletas' do 
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method)
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Preços por Distância'
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