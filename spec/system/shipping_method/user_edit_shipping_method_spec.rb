require 'rails_helper'

describe 'Usuário edita uma modalidade de frete' do 
  it 'a partir da tela inicial' do 
    ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    ShippingMethod.create!(name: 'itens Grandes', minimum_distance: 0, maximum_distance: 2, minimum_weight: 50, maximum_weight: 500, flat_rate: 32)

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
    ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)

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
  end

  it 'com informações incompletas' do 
    ShippingMethod.create!(name: 'Super veloz', minimum_distance: 0, maximum_distance: 4, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)

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