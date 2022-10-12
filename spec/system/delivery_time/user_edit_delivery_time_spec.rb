require 'rails_helper'

describe 'Usuário edita um prazo de entrega' do 
  it 'a partir da tela de listagem' do
    DeliveryTime.create!(minimum_distance: 0, maximum_distance: 100, deadline_in_hours: 48)

    visit root_path
    click_on 'Prazos de Entrega'
    click_on 'Editar'

    expect(page).to have_content 'Editar Prazo de Entrega'
    expect(page).to have_field 'Distância Mínima', with: '0'
    expect(page).to have_field 'Distância Máxima', with:'100'
    expect(page).to have_field 'Prazo em Horas', with:'48'
  end

  it 'com sucesso' do 
    DeliveryTime.create!(minimum_distance: 0, maximum_distance: 100, deadline_in_hours: 48)

    visit root_path
    click_on 'Prazos de Entrega'
    click_on 'Editar'
    fill_in 'Distância Mínima', with: '101'
    fill_in 'Distância Máxima', with: '300'
    fill_in 'Prazo em Horas', with: '96'
    click_on 'Salvar'

    expect(current_url).to eq delivery_times_url
    expect(page).to have_content 'Prazo de entrega atualizado com sucesso.'
    expect(page).to have_content 'Tabela de Prazos de Entrega'
    expect(page).to have_content '101'
    expect(page).to have_content '300'
    expect(page).to have_content '96'
    expect(page).not_to have_content '100'
    expect(page).not_to have_content '48'
  end

  it 'com informações incompletas' do 
    DeliveryTime.create!(minimum_distance: 0, maximum_distance: 100, deadline_in_hours: 48)

    visit root_path
    click_on 'Prazos de Entrega'
    click_on 'Editar'
    fill_in 'Distância Mínima', with: ''
    fill_in 'Distância Máxima', with: ''
    fill_in 'Prazo em Horas', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Prazo de entrega não foi atualizado.'
    expect(page).to have_content 'Distância Mínima não pode ficar em branco'
    expect(page).to have_content 'Distância Máxima não pode ficar em branco'
    expect(page).to have_content 'Prazo em Horas não pode ficar em branco'
  end
end
