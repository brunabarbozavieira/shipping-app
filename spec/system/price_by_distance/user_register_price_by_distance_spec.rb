require 'rails_helper'

describe 'Usuário cadastra novo preço por distância' do 
  it 'a partir da tela de listagem' do
    visit root_path
    click_on 'Preço por Distância'
    click_on 'Cadastrar novo preço por distância'

    expect(page).to have_field 'Distância Mínima'
    expect(page).to have_field 'Distância Máxima'
    expect(page).to have_field 'Taxa'
    expect(page).to have_button 'Salvar'
  end

  it 'com sucesso' do 
    visit root_path
    click_on 'Preço por Distância'
    click_on 'Cadastrar novo preço por distância'
    fill_in 'Distância Mínima', with: '0'
    fill_in 'Distância Máxima', with: '50'
    fill_in 'Taxa', with: '9'
    click_on 'Salvar'

    expect(current_url).to eq price_by_distances_url
    expect(page).to have_content 'Preço por distância cadastrado com sucesso.'
    expect(page).to have_content 'Tabela de Preço por Distância'
    expect(page).to have_content '0'
    expect(page).to have_content '50'
    expect(page).to have_content '9'
  end

  it 'com informações incompletas' do 
    visit root_path
    click_on 'Preço por Distância'
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