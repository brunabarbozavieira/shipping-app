require 'rails_helper'

describe 'Usuário cadastra novo preço por peso' do 
  it 'a partir da tela de listagem' do
    visit root_path
    click_on 'Preço por Peso'
    click_on 'Cadastrar novo preço por peso'

    expect(page).to have_field 'Peso Mínimo'
    expect(page).to have_field 'Peso Máximo'
    expect(page).to have_field 'Preço por km'
    expect(page).to have_button 'Salvar'
  end

  it 'com sucesso' do 
    visit root_path
    click_on 'Preço por Peso'
    click_on 'Cadastrar novo preço por peso'
    fill_in 'Peso Mínimo', with: '0'
    fill_in 'Peso Máximo', with: '10'
    fill_in 'Preço por km', with: '0.5'
    click_on 'Salvar'

    expect(current_url).to eq price_by_weights_url
    expect(page).to have_content 'Preço por peso cadastrado com sucesso.'
    expect(page).to have_content 'Tabela de Preço por Peso'
    expect(page).to have_content '0'
    expect(page).to have_content '10'
    expect(page).to have_content '0.5'
  end

  it 'com informações incompletas' do 
    visit root_path
    click_on 'Preço por Peso'
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