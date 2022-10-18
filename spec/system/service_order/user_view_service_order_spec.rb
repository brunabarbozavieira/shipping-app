require 'rails_helper'

describe 'Usuário vê ordens de serviço pendente' do 
  it 'a partir da tela inicial' do 
    ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                          weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                          email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                          total_distance: 15, status: 'pending')
    ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '5T85YHT78EI56BD', dimensions: '104cm x 54cm x 61cm', 
                          weight: 32, recipient_name: 'Rosa de Souza Melo', identification_document: '10328832006', contact_phone: '11988880000', 
                          email: 'rosasm@email.com.br', full_delivery_address: 'Rua Frida Kahlo, 257 - Jundiaí - SP',
                          total_distance: 60, status: 'pending')
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

    login_as regular
    visit root_path
    click_on 'Ordens de Serviço'

    expect(current_url).to eq service_orders_url
    expect(page).to have_content 'Lista de Ordens de Serviço'
    expect(page).to have_content 'Código da Ordem de Serviço'
    expect(page).to have_content "#{ServiceOrder.first.service_order_code}"
    expect(page).to have_content "#{ServiceOrder.last.service_order_code}"
    expect(page).to have_content 'Status'
    expect(page).to have_content 'Pendente'
  end

  it 'e não vê as ordens de serviço iniciada ou encerrada' do 
    first_service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                          weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                          email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                          total_distance: 15, status: 'pending')
    second_service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '5T85YHT78EI56BD', dimensions: '104cm x 54cm x 61cm', 
                          weight: 32, recipient_name: 'Rosa de Souza Melo', identification_document: '10328832006', contact_phone: '11988880000', 
                          email: 'rosasm@email.com.br', full_delivery_address: 'Rua Frida Kahlo, 257 - Jundiaí - SP',
                          total_distance: 60, status: 'started')
    third_service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '7Y55GKL11BB87AA', dimensions: '101cm x 88cm x 3cm', 
                          weight: 8, recipient_name: 'Gabriela da Silva Lopes', identification_document: '71493786091', contact_phone: '19977770000', 
                          email: 'gabrielasl@email.com.br', full_delivery_address: 'Rua Candido Portinari, 257 - Campinas - SP',
                          total_distance: 60, status: 'closed')
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

    login_as regular
    visit root_path
    click_on 'Ordens de Serviço'

    expect(page).to have_content "#{first_service_order.service_order_code}"
    expect(page).not_to have_content "#{second_service_order.service_order_code}"
    expect(page).not_to have_content "#{third_service_order.service_order_code}"

  end

  it 'e não existem oredens de serviço cadastradas' do 
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

    login_as regular
    visit root_path
    click_on 'Ordens de Serviço'

    expect(page).to have_content 'Não existem ordens de serviço cadastradas.'
    expect(page).not_to have_content 'Código da Ordem de Serviço'
    expect(page).not_to have_content 'Status'
  end
end