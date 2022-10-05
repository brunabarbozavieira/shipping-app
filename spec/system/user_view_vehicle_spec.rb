require 'rails_helper'

describe 'Usuário vê veículos' do
  it 'a partir do menu' do 
    Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650)
    Vehicle.create!(license_plate:'KQV6B36', brand:'Renault', model: 'Kangoo', year_of_manufacture: 2020, maximum_load_capacity: 800)

    visit root_path
    click_on 'Veículos'

    expect(page).to have_content 'Fiorino'
    expect(page).to have_content 'Kangoo'
  end

  it 'e não existem veículos cadastrados' do 
    visit root_path
    click_on 'Veículos'

    expect(page).to have_content 'Não existem veículos cadastrados.'
    expect(page).not_to have_content 'Modelo'
    expect(page).not_to have_content 'Marca'
  end

end