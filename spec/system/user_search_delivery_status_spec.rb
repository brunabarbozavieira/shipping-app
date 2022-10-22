require 'rails_helper'

describe 'Usuário consulta situação da entrega' do 
  it 'a partir da tela inicial' do 
    visit root_path
    
    expect(page).to have_content 'Consulte aqui a situação da sua entrega'
    expect(page).to have_field 'Código de Rastreio'
    expect(page).to have_button 'Consultar'
  end

  it 'com sucesso e dentro do prazo' do 
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 10, maximum_distance: 30, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    vehicle = Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method)
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method)
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5, shipping_method: shipping_method)
    DeliveryTime.create!(minimum_distance:0, maximum_distance:100, deadline_in_hours: 48, shipping_method: shipping_method)
    service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                                           weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                                           email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                                           total_distance: 15, total_delivery_value: 22.5, deadline: 48, shipping_method: shipping_method, status: 'started', vehicle: vehicle, start_date: 1.day.ago)

    visit root_path
    fill_in 'Código de Rastreio', with: service_order.service_order_code
    click_on 'Consultar'

    expect(page).to have_content 'Situação da Entrega: Iniciada'
    expect(page).to have_content "Data de Início: #{service_order.start_date}"
    expect(page).to have_content 'Veículo: Fiorino'
    expect(page).to have_content "Data Prevista de Entrega: #{service_order.start_date + service_order.deadline.hours}"
    expect(page).not_to have_content 'Data de Entrega:'
    expect(page).not_to have_content 'Motivo do Atraso: '
  end

  it 'com sucesso e em atraso' do 
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 10, maximum_distance: 30, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    vehicle = Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method)
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method)
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5, shipping_method: shipping_method)
    DeliveryTime.create!(minimum_distance:0, maximum_distance:100, deadline_in_hours: 48, shipping_method: shipping_method)
    service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                                           weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                                           email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                                           total_distance: 15, total_delivery_value: 22.5, deadline: 48, shipping_method: shipping_method, status: 'closed', vehicle: vehicle, start_date: 5.day.ago, reason_for_delay: 'Via interditada pela concessionária de trânsito.', delivery_date: DateTime.now)

    visit root_path
    fill_in 'Código de Rastreio', with: service_order.service_order_code
    click_on 'Consultar'

    expect(page).to have_content 'Situação da Entrega: Encerrada'
    expect(page).to have_content "Data de Início: #{service_order.start_date}"
    expect(page).to have_content 'Veículo: Fiorino'
    expect(page).to have_content "Data Prevista de Entrega: #{service_order.start_date + service_order.deadline.hours}"
    expect(page).to have_content "Data de Entrega: #{service_order.delivery_date}"
    expect(page).to have_content 'Motivo do Atraso: Via interditada pela concessionária de trânsito.'
  end
end