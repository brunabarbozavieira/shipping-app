require 'rails_helper'

describe 'Usuário desativa uma modalidade de frete' do
  it 'com sucesso' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')
    shipping_method = ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)

    login_as admin
    visit root_path
    click_on 'Modalidades de Frete'
    click_on 'Super veloz'
    click_on 'Desativar'

    expect(current_url).to eq shipping_method_url(shipping_method.id)
    expect(page).to have_content 'Status: Desativada'
    expect(page).to have_button 'Ativar'
    expect(page).not_to have_button 'Desativar'
  end

  it 'e não é o usuário administrador' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')
    shipping_method = ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)

    login_as regular
    visit root_path
    click_on 'Modalidades de Frete'
    click_on 'Super veloz'
    click_on 'Desativar'

    expect(current_url).to eq root_url
    expect(page).to have_content 'Usuário não possui autorização.'
  end
end

describe 'Usuário ativa uma modalidade de frete' do
  it 'com sucesso' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')
    shipping_method = ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6, status:'disabled')

    login_as admin
    visit root_path
    click_on 'Modalidades de Frete'
    click_on 'Super veloz'
    click_on 'Ativar'

    expect(current_url).to eq shipping_method_url(shipping_method.id)
    expect(page).to have_content 'Status: Ativa'
    expect(page).to have_button 'Desativar'
    expect(page).not_to have_button 'Ativar'
  end

  it 'e não é o usuário administrador' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')
    shipping_method = ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6, status: 'disabled')

    login_as regular
    visit root_path
    click_on 'Modalidades de Frete'
    click_on 'Super veloz'
    click_on 'Ativar'

    expect(current_url).to eq root_url
    expect(page).to have_content 'Usuário não possui autorização.'
  end
end