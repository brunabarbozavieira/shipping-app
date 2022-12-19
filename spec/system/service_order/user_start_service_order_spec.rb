require 'rails_helper'

describe 'Usuário inicia ordem de serviço selecionando uma modalidade de frete disponível' do 
  it 'e adiciona o valor total, o prazo e a modalidade de frete a ordem de serviço' do 
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 10, maximum_distance: 30, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method)
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method)
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5, shipping_method: shipping_method)
    DeliveryTime.create!(minimum_distance:0, maximum_distance:100, deadline_in_hours: 48, shipping_method: shipping_method)
    service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                                           weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                                           email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                                           total_distance: 15)
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

    login_as regular
    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.service_order_code
    select 'Modalidade de Frete: Super Veloz - Valor Total da Entrega: 22.5 - Prazo: 48 horas', from: 'Escolha a Modalidade de Frete'
    click_on 'Iniciar Ordem de Serviço'

    expect(page).to have_content 'Ordem de serviço iniciada com sucesso.'
    expect(page).to have_content 'Status: Iniciada'
    expect(page).to have_content 'Valor Total da Entrega: R$ 22,50'
    expect(page).to have_content 'Prazo: 48 horas'
    expect(page).to have_content 'Modalidade de Frete: Super Veloz'
    expect(current_url).to eq service_order_url(service_order.id)
    expect(page).not_to have_content 'Escolha a Modalidade de Frete'
    
  end

  it 'e aciona um veículo para executar a ordem de serviço' do 
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 10, maximum_distance: 30, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method)
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method)
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5, shipping_method: shipping_method)
    DeliveryTime.create!(minimum_distance:0, maximum_distance:100, deadline_in_hours: 48, shipping_method: shipping_method)
    service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                                           weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                                           email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                                           total_distance: 15)
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

    login_as regular
    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.service_order_code
    select 'Modalidade de Frete: Super Veloz - Valor Total da Entrega: 22.5 - Prazo: 48 horas', from: 'Escolha a Modalidade de Frete'
    click_on 'Iniciar Ordem de Serviço'

    expect(Vehicle.first.status).to eq 'operation'
  end
end