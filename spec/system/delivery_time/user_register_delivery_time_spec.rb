require 'rails_helper'

describe 'Usuário cadastra novo prazo de entrega' do 
  it 'a partir da tela de listagem' do
    visit root_path
    click_on 'Prazos de Entrega'
    click_on 'Cadastrar novo prazo de entrega'

    expect(page).to have_field 'Distância Mínima'
    expect(page).to have_field 'Distância Máxima'
    expect(page).to have_field 'Prazo em Horas'
    expect(page).to have_button 'Salvar'
  end

  it 'com sucesso' do 
    visit root_path
    click_on 'Prazos de Entrega'
    click_on 'Cadastrar novo prazo de entrega'
    fill_in 'Distância Mínima', with: '0'
    fill_in 'Distância Máxima', with: '100'
    fill_in 'Prazo em Horas', with: '48'
    click_on 'Salvar'

    expect(current_url).to eq delivery_times_url
    expect(page).to have_content 'Prazo de entrega cadastrado com sucesso.'
    expect(page).to have_content 'Tabela de Prazos de Entrega'
    expect(page).to have_content '0'
    expect(page).to have_content '100'
    expect(page).to have_content '48'
  end

  it 'com informações incompletas' do 
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