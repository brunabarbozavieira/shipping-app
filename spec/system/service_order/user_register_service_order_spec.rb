require 'rails_helper'

describe 'Usuário cadastra uma ordem de serviço' do 
  it 'a partir da tela de listagem' do 
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Cadastrar Nova Ordem de Serviço'

    expect(page).to have_field 'Endereço para Retirada'
    expect(page).to have_field 'Código do Produto'
    expect(page).to have_field 'Dimensões'
    expect(page).to have_field 'Peso'
    expect(page).to have_field 'Nome do Destinatário'
    expect(page).to have_field 'CPF'
    expect(page).to have_field 'Telefone'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Endereço para Entrega'
    expect(page).to have_field 'Distância Total'
  end

  it 'com sucesso' do 
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Cadastrar Nova Ordem de Serviço'
    fill_in 'Endereço para Retirada', with: 'Rua Salvador Dali, 341 - São Paulo - SP'
    fill_in 'Código do Produto', with: '5T85YHT78EI56BD'
    fill_in 'Dimensões', with: '104cm x 54cm x 61cm'
    fill_in 'Peso', with: 32
    fill_in 'Nome do Destinatário', with: 'Rosa de Souza Melo'
    fill_in 'CPF', with: '10328832006'
    fill_in 'Telefone', with: '11988880000'
    fill_in 'E-mail', with: 'rosasm@email.com.br'
    fill_in 'Endereço para Entrega', with: 'Rua Frida Kahlo, 257 - Jundiaí - SP'
    fill_in 'Distância Total', with: 60
    click_on 'Criar Ordem de Serviço'

    expect(page).to have_content 'Endereço para Retirada: Rua Salvador Dali, 341 - São Paulo - SP'
    expect(page).to have_content 'Código do Produto: 5T85YHT78EI56BD'
    expect(page).to have_content 'Dimensões: 104cm x 54cm x 61cm'
    expect(page).to have_content 'Peso: 32.0 kg'
    expect(page).to have_content 'Nome do Destinatário: Rosa de Souza Melo'
    expect(page).to have_content 'CPF: 103.288.320-06'
    expect(page).to have_content 'Telefone: (11)98888-0000'
    expect(page).to have_content 'E-mail: rosasm@email.com.br'
    expect(page).to have_content 'Endereço para Entrega: Rua Frida Kahlo, 257 - Jundiaí - SP'
    expect(page).to have_content 'Distância Total: 60km'
    expect(page).to have_content  "#{ServiceOrder.last.service_order_code}"
    expect(page).to have_content 'Status: Pendente'
  end

  it 'com informações incompletas' do 
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Cadastrar Nova Ordem de Serviço'
    fill_in 'Endereço para Retirada', with: ''
    fill_in 'Código do Produto', with: ''
    fill_in 'Dimensões', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Nome do Destinatário', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Endereço para Entrega', with: ''
    fill_in 'Distância Total', with: ''
    click_on 'Criar Ordem de Serviço'

    expect(page).to have_content 'Ordem de serviço não cadastrada.'
    expect(page).to have_content 'Endereço para Retirada não pode ficar em branco'
    expect(page).to have_content 'Código do Produto não pode ficar em branco'
    expect(page).to have_content 'Dimensões não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
    expect(page).to have_content 'Nome do Destinatário não pode ficar em branco'
    expect(page).to have_content 'CPF não pode ficar em branco'
    expect(page).to have_content 'Telefone não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Endereço para Entrega não pode ficar em branco'
    expect(page).to have_content 'Distância Total não pode ficar em branco'
    end
end
