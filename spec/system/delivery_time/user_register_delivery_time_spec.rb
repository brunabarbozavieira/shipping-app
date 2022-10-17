require 'rails_helper'

describe 'Usuário cadastra novo prazo de entrega' do 
  it 'se estiver autenticado como usuário administrador' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Prazos de Entrega'
    click_on 'Cadastrar novo prazo de entrega'
    
    expect(current_url).to eq new_delivery_time_url
  end

  it 'e não possui permissão' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

    login_as regular
    visit root_path
    click_on 'Prazos de Entrega'
    click_on 'Cadastrar novo prazo de entrega'
    
    expect(current_url).to eq root_url
    expect(page).to have_content 'Usuário não possui autorização.'
  end

  it 'a partir da tela de listagem' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Prazos de Entrega'
    click_on 'Cadastrar novo prazo de entrega'

    expect(page).to have_field 'Distância Mínima'
    expect(page).to have_field 'Distância Máxima'
    expect(page).to have_field 'Prazo em Horas'
    expect(page).to have_field 'Modalidade de Frete'
    expect(page).to have_button 'Salvar'
  end

  it 'com sucesso' do 
    ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    ShippingMethod.create!(name: 'Itens Grandes', minimum_distance: 0, maximum_distance: 2, minimum_weight: 50, maximum_weight: 500, flat_rate: 32)
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Prazos de Entrega'
    click_on 'Cadastrar novo prazo de entrega'
    fill_in 'Distância Mínima', with: '0'
    fill_in 'Distância Máxima', with: '100'
    fill_in 'Prazo em Horas', with: '48'
    select 'Super Veloz', from: 'Modalidade de Frete'
    click_on 'Salvar'

    expect(current_url).to eq delivery_times_url
    expect(page).to have_content 'Prazo de entrega cadastrado com sucesso.'
    expect(page).to have_content 'Tabela de Prazos de Entrega'
    expect(page).to have_content '0'
    expect(page).to have_content '100'
    expect(page).to have_content '48'
    expect(page).to have_content 'Super Veloz'
  end

  it 'com informações incompletas' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Prazos de Entrega'
    click_on 'Cadastrar novo prazo de entrega'
    fill_in 'Distância Mínima', with: ''
    fill_in 'Distância Máxima', with: ''
    fill_in 'Prazo em Horas', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Prazo de entrega não cadastrado.'
    expect(page).to have_content 'Distância Mínima não pode ficar em branco'
    expect(page).to have_content 'Distância Máxima não pode ficar em branco'
    expect(page).to have_content 'Prazo em Horas não pode ficar em branco'
  end
end