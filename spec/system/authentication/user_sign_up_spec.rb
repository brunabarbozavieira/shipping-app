require 'rails_helper'

describe 'Usuário se autentica' do 
  it 'com sucesso' do 
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Administrador'
    fill_in 'E-mail', with: 'admin@sistemadefrete.com.br'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    click_on 'Criar conta'

    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'admin@sistemadefrete.com.br'
    expect(page).to have_button 'Sair'
    user = User.last
    expect(user.name).to eq 'Administrador'
    
  end
end