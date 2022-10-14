require 'rails_helper'

describe 'Usuário cadastra modalidade de frete' do 
  it 'sem estar autenticado' do 
    visit root_path
    click_on 'Modalidades de Frete' 
    click_on 'Cadastrar Nova Modalidade de Frete'
    
    expect(current_url).to eq new_user_session_url
  end

  it 'se estiver autenticado como usuário administrador' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Modalidades de Frete' 
    click_on 'Cadastrar Nova Modalidade de Frete'
    
    expect(current_url).to eq new_shipping_method_url
  end

  it 'e não possui permissão' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

    login_as regular
    visit root_path
    click_on 'Modalidades de Frete' 
    click_on 'Cadastrar Nova Modalidade de Frete'
    
    expect(current_url).to eq root_url
    expect(page).to have_content 'Usuário não possui autorização.'
  end

  it 'a partir da tela inicial' do
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Modalidades de Frete' 
    click_on 'Cadastrar Nova Modalidade de Frete'

    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Distância Mínima'
    expect(page).to have_field 'Distância Máxima'
    expect(page).to have_field 'Peso Mínimo'
    expect(page).to have_field 'Peso Máximo'
    expect(page).to have_field 'Taxa Fixa'
  end

  it 'com sucesso' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Modalidades de Frete' 
    click_on 'Cadastrar Nova Modalidade de Frete'
    fill_in 'Nome', with: 'Super Veloz'
    fill_in 'Distância Mínima', with: '0'
    fill_in 'Distância Máxima', with: '15'
    fill_in 'Peso Mínimo', with: '0'
    fill_in 'Peso Máximo', with: '20'
    fill_in 'Taxa Fixa', with: '6'
    click_on 'Criar Modalidade de Frete'
    
    expect(page).to have_content 'Modalidade de frete cadastrada com sucesso.'
    expect(page).to have_content 'Super Veloz'
    expect(page).to have_content 'Distância Mínima: 0'
    expect(page).to have_content 'Distância Máxima: 15'
    expect(page).to have_content 'Peso Mínimo: 0'
    expect(page).to have_content 'Peso Máximo: 20'
    expect(page).to have_content 'Taxa Fixa: 6'
  end

  it 'com informações incompletas' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Modalidades de Frete' 
    click_on 'Cadastrar Nova Modalidade de Frete'
    fill_in 'Nome', with: ''
    fill_in 'Distância Mínima', with: ''
    fill_in 'Distância Máxima', with: ''
    fill_in 'Peso Mínimo', with: ''
    fill_in 'Peso Máximo', with: ''
    fill_in 'Taxa Fixa', with: ''
    click_on 'Criar Modalidade de Frete'
    
    expect(page).to have_content 'Modalidade de frete não cadastrada.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Distância Mínima não pode ficar em branco'
    expect(page).to have_content 'Distância Máxima não pode ficar em branco'
    expect(page).to have_content 'Peso Mínimo não pode ficar em branco'
    expect(page).to have_content 'Peso Máximo não pode ficar em branco'
    expect(page).to have_content 'Taxa Fixa não pode ficar em branco'

  end
end