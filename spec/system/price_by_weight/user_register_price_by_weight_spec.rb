require 'rails_helper'

describe 'Usuário cadastra novo preço por peso' do 
  it 'se estiver autenticado como usuário administrador' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Preços por Peso'
    click_on 'Cadastrar novo preço por peso'
    
    expect(current_url).to eq new_price_by_weight_url
  end

  it 'e não possui permissão' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

    login_as regular
    visit root_path
    click_on 'Preços por Peso'
    click_on 'Cadastrar novo preço por peso'
    
    expect(current_url).to eq root_url
    expect(page).to have_content 'Usuário não possui autorização.'
  end

  it 'a partir da tela de listagem' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
  
    visit root_path
    click_on 'Preços por Peso'
    click_on 'Cadastrar novo preço por peso'

    expect(page).to have_field 'Peso Mínimo'
    expect(page).to have_field 'Peso Máximo'
    expect(page).to have_field 'Preço por km'
    expect(page).to have_field 'Modalidade de Frete'
    expect(page).to have_button 'Salvar'
  end

  it 'com sucesso' do 
    ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    ShippingMethod.create!(name: 'Itens Grandes', minimum_distance: 0, maximum_distance: 2, minimum_weight: 50, maximum_weight: 500, flat_rate: 32)
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin

    visit root_path
    click_on 'Preços por Peso'
    click_on 'Cadastrar novo preço por peso'
    fill_in 'Peso Mínimo', with: '0'
    fill_in 'Peso Máximo', with: '10'
    fill_in 'Preço por km', with: '0.5'
    select 'Super Veloz', from: 'Modalidade de Frete'
    click_on 'Salvar'

    expect(current_url).to eq price_by_weights_url
    expect(page).to have_content 'Preço por peso cadastrado com sucesso.'
    expect(page).to have_content 'Tabela de Preço por Peso'
    expect(page).to have_content '0'
    expect(page).to have_content '10'
    expect(page).to have_content '0.5'
  end

  it 'com informações incompletas' do 
    ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
  
    visit root_path
    click_on 'Preços por Peso'
    click_on 'Cadastrar novo preço por peso'
    fill_in 'Peso Mínimo', with: ''
    fill_in 'Peso Máximo', with: ''
    fill_in 'Preço por km', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Preço por peso não cadastrado.'
    expect(page).to have_content 'Peso Mínimo não pode ficar em branco'
    expect(page).to have_content 'Peso Máximo não pode ficar em branco'
    expect(page).to have_content 'Preço por km não pode ficar em branco'
  end
end