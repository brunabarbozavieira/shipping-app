require 'rails_helper'

describe 'Usuário cadastra um veículo' do 
  it 'sem estar autenticado' do 
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    
    expect(current_url).to eq new_user_session_url
  end

  it 'se estiver autenticado como usuário administrador' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    
    expect(current_url).to eq new_vehicle_url
  end

  it 'e não possui permissão' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

    login_as regular
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    
    expect(current_url).to eq root_url
    expect(page).to have_content 'Usuário não possui autorização.'
  end

  it 'a partir da página de listagem' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'

    expect(page).to have_field 'Placa'
    expect(page).to have_field 'Marca'
    expect(page).to have_field 'Modelo'
    expect(page).to have_field 'Ano de Fabricação'
    expect(page).to have_field 'Capacidade Máxima de Carga'
    expect(page).to have_button 'Salvar'
  end

  it 'com sucesso' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    fill_in 'Placa', with: 'MRO4H51'
    fill_in 'Marca', with: 'Fiat'
    fill_in 'Modelo', with: 'Fiorino'
    select '2019', from: 'Ano de Fabricação'
    fill_in 'Capacidade Máxima de Carga', with: '650'
    click_on 'Salvar'

    expect(page).to have_content 'Fiorino'
    expect(page).to have_content 'Veículo cadastrado com sucesso.'
    expect(page).to have_content 'Placa: MRO4H51'
    expect(page).to have_content 'Marca: Fiat'
    expect(page).to have_content 'Ano de Fabricação: 2019'
    expect(page).to have_content 'Capacidade Máxima de Carga: 650 kg'
  end

  it 'com informacões incompletas' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')

    login_as admin
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    fill_in 'Placa', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Modelo', with: ''
    fill_in 'Capacidade Máxima de Carga', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Veículo não cadastrado.'
    expect(page).to have_content 'Placa não pode ficar em branco'
    expect(page).to have_content 'Marca não pode ficar em branco'
    expect(page).to have_content 'Modelo não pode ficar em branco'
    expect(page).to have_content 'Capacidade Máxima de Carga não pode ficar em branco'
  end
end