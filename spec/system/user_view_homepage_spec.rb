require 'rails_helper'

describe 'Usuário visita a tela inicial' do
  it ' e vê o nome da aplicação' do
    visit root_path

    expect(page).to have_content 'Frete Rápido'
  end
  
  it 'a partir de qualquer página da aplicação' do 
    visit vehicles_url
    within 'nav' do 
      click_on 'Página Inicial'
    end

    expect(current_path).to eq root_path
  end
end