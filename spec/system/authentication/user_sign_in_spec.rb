require 'rails_helper'

describe 'Usuário admin se autentica' do 
  it 'com sucesso' do 
    User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')
    visit root_path
    click_on 'Entrar'
    within 'form' do 
      fill_in 'E-mail', with: 'admin@sistemadefrete.com.br'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
    within 'nav' do 
      expect(page).to have_button 'Sair'
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_content 'Usuário Administrador - admin@sistemadefrete.com.br'
    end
  end

  it 'e faz logout' do 
    User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador')
    visit root_path
    click_on 'Entrar'
    within 'form' do 
      fill_in 'E-mail', with: 'admin@sistemadefrete.com.br'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_content 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'Usuário Administrador - admin@sistemadefrete.com.br'
  end
end
describe 'Usuário regular se autentica' do 
  it 'com sucesso' do 
    User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')
    visit root_path
    click_on 'Entrar'
    within 'form' do 
      fill_in 'E-mail', with: 'regular@sistemadefrete.com.br'
      fill_in 'Senha', with: 'abcdefgh'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso.'
    within 'nav' do 
      expect(page).to have_button 'Sair'
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_content 'Usuário Regular - regular@sistemadefrete.com.br'
    end
  end

  it 'e faz logout' do 
    User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')
    visit root_path
    click_on 'Entrar'
    within 'form' do 
      fill_in 'E-mail', with: 'regular@sistemadefrete.com.br'
      fill_in 'Senha', with: 'abcdefgh'
      click_on 'Entrar'
    end
    click_on 'Sair'
  
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_content 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'Usuário Regular - regular@sistemadefrete.com.br'
  end
end