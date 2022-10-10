require 'rails_helper'

describe 'Usuário edita um veículo' do 
  it 'a partir da tela inicial' do 
    Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650)

    visit root_path
    click_on 'Veículos'
    click_on 'MRO4H51'
    click_on 'Editar'

    expect(page).to have_content 'Editar Veículo'
    expect(page).to have_field 'Placa', with: 'MRO4H51'
    expect(page).to have_field 'Marca', with:'Fiat'
    expect(page).to have_field 'Modelo', with:'Fiorino'
    expect(page).to have_field 'Ano de Fabricação', with: '2019'
    expect(page).to have_field 'Capacidade Máxima de Carga', with:'650'
    expect(page).to have_button 'Salvar'
  end

  it 'com sucesso' do 
    Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650)

    visit root_path
    click_on 'Veículos'
    click_on 'MRO4H51'
    click_on 'Editar'
    fill_in 'Placa', with: 'KQV6B36'
    fill_in 'Marca', with: 'Renault'
    fill_in 'Modelo', with: 'Kangoo'
    select '2020', from: 'Ano de Fabricação'
    fill_in 'Capacidade Máxima de Carga', with: '800'
    click_on 'Salvar'

    expect(page).to have_content 'Veículo atualizado com sucesso.'
    expect(page).to have_content 'Placa: KQV6B36'
    expect(page).to have_content 'Marca: Renault'
    expect(page).to have_content 'Ano de Fabricação: 2020'
    expect(page).to have_content 'Capacidade Máxima de Carga: 800 kg'
  end

  it 'com informações incompletas'  do 
    Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650)

    visit root_path
    click_on 'Veículos'
    click_on 'MRO4H51'
    click_on 'Editar'
    fill_in 'Placa', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Modelo', with: ''
    fill_in 'Capacidade Máxima de Carga', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Veículo não foi atualizado'
    expect(page).to have_content 'Placa não pode ficar em branco'
    expect(page).to have_content 'Marca não pode ficar em branco'
    expect(page).to have_content 'Modelo não pode ficar em branco'
    expect(page).to have_content 'Capacidade Máxima de Carga não pode ficar em branco'
  end
end