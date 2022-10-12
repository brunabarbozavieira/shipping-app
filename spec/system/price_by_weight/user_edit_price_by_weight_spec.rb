require 'rails_helper'

describe 'Usuário edita preço por peso' do 
  it 'a partir da tela inicial' do
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5)

    visit root_path
    click_on 'Preços por Peso'
    click_on 'Editar'

    expect(page).to have_content 'Editar Preço por Peso'
    expect(page).to have_field 'Peso Mínimo', with: '0'
    expect(page).to have_field 'Peso Máximo', with:'10'
    expect(page).to have_field 'Preço por km', with:'0.5'
  end

  it 'com sucesso' do 
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5)

    visit root_path
    click_on 'Preços por Peso'
    click_on 'Editar'
    fill_in 'Peso Mínimo', with:'50'
    fill_in 'Peso Máximo', with:'500'
    fill_in 'Preço por km', with:'32'
    click_on 'Salvar'

    expect(page).to have_content 'Preço por peso atualizado com sucesso.'
    expect(page).to have_content '50'
    expect(page).to have_content '500'
    expect(page).to have_content '32'
    expect(page).not_to have_content '10'
    expect(page).not_to have_content '0.5'
  end

  it 'com informações incompletas' do 
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5)

    visit root_path
    click_on 'Preços por Peso'
    click_on 'Editar'
    fill_in 'Peso Mínimo', with:''
    fill_in 'Peso Máximo', with:''
    fill_in 'Preço por km', with:''
    click_on 'Salvar'

    expect(page).to have_content 'Preço por peso não foi atualizado.'
    expect(page).to have_content 'Peso Mínimo não pode ficar em branco'
    expect(page).to have_content 'Peso Máximo não pode ficar em branco'
    expect(page).to have_content 'Preço por km não pode ficar em branco'
  end
end