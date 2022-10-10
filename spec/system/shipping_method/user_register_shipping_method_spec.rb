require 'rails_helper'

describe 'Usuário cadastra modalidade de frete' do 
  it 'a partir da tela inicial' do
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