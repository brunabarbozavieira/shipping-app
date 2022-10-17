require 'rails_helper'

describe 'Usuário edita uma modalidade de frete' do 
  it 'sem estar autenticado' do 
    ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)

    visit root_path
    click_on 'Modalidades de Frete' 
    click_on 'Super Veloz'
    click_on 'Editar'
    
    expect(current_url).to eq new_user_session_url
  end

  it 'se estiver autenticado como usuário administrador' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)

    login_as admin
    visit root_path
    click_on 'Modalidades de Frete' 
    click_on 'Super Veloz'
    click_on 'Editar'
    
    expect(current_url).to eq edit_shipping_method_url(shipping_method.id)
  end

  it 'e não possui permissão' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)

    login_as regular
    visit root_path
    click_on 'Modalidades de Frete' 
    click_on 'Super Veloz'
    click_on 'Editar'
    
    expect(current_url).to eq root_url
    expect(page).to have_content 'Usuário não possui autorização.'
  end
  
  it 'a partir da tela inicial' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')
    ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
  
    login_as admin
    visit root_path
    click_on 'Modalidades de Frete'
    click_on 'Super veloz'
    click_on 'Editar'

    expect(page).to have_content 'Editar Modalidade de Frete'
    expect(page).to have_field 'Nome', with: 'Super veloz'
    expect(page).to have_field 'Distância Mínima', with:'0'
    expect(page).to have_field 'Distância Máxima', with:'4'
    expect(page).to have_field 'Peso Mínimo', with:'0'
    expect(page).to have_field 'Peso Máximo', with:'20'
    expect(page).to have_field 'Taxa Fixa', with:'6.0'
  end

  it 'com sucesso' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')
    ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)

    login_as admin
    visit root_path
    click_on 'Modalidades de Frete'
    click_on 'Super veloz'
    click_on 'Editar'
    fill_in 'Nome', with: 'Itens Grandes'
    fill_in 'Distância Mínima', with:'0'
    fill_in 'Distância Máxima', with:'2'
    fill_in 'Peso Mínimo', with:'50'
    fill_in 'Peso Máximo', with:'500'
    fill_in 'Taxa Fixa', with:'32'
    click_on 'Salvar'

    expect(page).to have_content 'Modalidade de frete atualizada com sucesso.'
    expect(page).to have_content 'Itens Grandes'
    expect(page).to have_content 'Distância Mínima: 0'
    expect(page).to have_content 'Distância Máxima: 2'
    expect(page).to have_content 'Peso Mínimo: 50'
    expect(page).to have_content 'Peso Máximo: 500'
    expect(page).to have_content 'Taxa Fixa: 32'
    expect(page).not_to have_content 'Super veloz'
  end

  it 'com informações incompletas' do 
    admin = User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')
    ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)

    login_as admin
    visit root_path
    click_on 'Modalidades de Frete' 
    click_on 'Super veloz'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Distância Mínima', with: ''
    fill_in 'Distância Máxima', with: ''
    fill_in 'Peso Mínimo', with: ''
    fill_in 'Peso Máximo', with: ''
    fill_in 'Taxa Fixa', with: ''
    click_on 'Salvar'
    
    expect(page).to have_content 'Modalidade de frete não atualizada.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Distância Mínima não pode ficar em branco'
    expect(page).to have_content 'Distância Máxima não pode ficar em branco'
    expect(page).to have_content 'Peso Mínimo não pode ficar em branco'
    expect(page).to have_content 'Peso Máximo não pode ficar em branco'
    expect(page).to have_content 'Taxa Fixa não pode ficar em branco'
  end
end