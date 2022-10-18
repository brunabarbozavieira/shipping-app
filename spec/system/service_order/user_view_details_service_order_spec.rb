require 'rails_helper'

describe 'Usuário vê detalhes de uma ordem de serviço' do 
  it 'a partir da tela de listagem' do 
    service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                          weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                          email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                          total_distance: 15)
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

    login_as regular
    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.service_order_code

    expect(page).to have_content 'Detalhes da Ordem de Serviço'
    expect(page).to have_content service_order.service_order_code
    expect(page).to have_content 'Endereço para Retirada: Rua Salvador Dali, 341 - São Paulo - SP'
    expect(page).to have_content 'Código do Produto: 2FE5T46YE7HCBIE'
    expect(page).to have_content 'Dimensões: 15cm x 5cm x 5cm'
    expect(page).to have_content 'Peso: 0.2 kg'
    expect(page).to have_content 'Nome do Destinatário: Roberto Carlos Ferreira'
    expect(page).to have_content 'CPF: 560.303.660-50'
    expect(page).to have_content 'Telefone: (11)99999-0000'
    expect(page).to have_content 'E-mail: robertocf@email.com.br'
    expect(page).to have_content 'Endereço para Entrega: Rua Leonardo da Vinci, 490 - São Paulo - SP'
    expect(page).to have_content 'Distância Total: 15 km'
  end
end