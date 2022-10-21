require 'rails_helper'

describe 'Usuário encerra uma ordem de serviço' do 
  it 'a partir da tela inicial' do 
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 10, maximum_distance: 30, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method)
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method)
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5, shipping_method: shipping_method)
    DeliveryTime.create!(minimum_distance:0, maximum_distance:100, deadline_in_hours: 48, shipping_method: shipping_method)
    service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                                           weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                                           email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                                           total_distance: 15, total_delivery_value: 22.5, deadline: 48, shipping_method: shipping_method, status: 'started' )
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

    login_as regular
    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.service_order_code

    expect(page).to have_button "Encerrar Ordem de Serviço"
  end

  it 'com atraso' do 
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 10, maximum_distance: 30, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    vehicle = Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method)
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method)
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5, shipping_method: shipping_method)
    DeliveryTime.create!(minimum_distance:0, maximum_distance:100, deadline_in_hours: 48, shipping_method: shipping_method)
    service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                                           weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                                           email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                                           total_distance: 15, total_delivery_value: 22.5, deadline: 48, shipping_method: shipping_method, status: 'started', vehicle: vehicle, start_date: 5.days.ago)
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

    login_as regular
    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.service_order_code
    fill_in 'Motivo do Atraso', with: 'Via interditada pela concessionária de trânsito.'
    click_on 'Encerrar Ordem de Serviço'

    expect(page).to have_content 'Ordem de serviço encerrada com sucesso.'
    expect(page).to have_content DateTime.now.utc.to_s
    expect(page).to have_content 'Motivo do Atraso: Via interditada pela concessionária de trânsito.'
    expect(page).to have_content 'Status: Encerrada'
    expect(Vehicle.first.status).to eq 'available'
  end

  it 'dentro do prazo' do 
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 10, maximum_distance: 30, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    vehicle = Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method)
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method)
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5, shipping_method: shipping_method)
    DeliveryTime.create!(minimum_distance:0, maximum_distance:100, deadline_in_hours: 48, shipping_method: shipping_method)
    service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                                           weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                                           email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                                           total_distance: 15, total_delivery_value: 22.5, deadline: 48, shipping_method: shipping_method, status: 'started', vehicle: vehicle, start_date: 1.day.ago)
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

    login_as regular
    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.service_order_code
    click_on 'Encerrar Ordem de Serviço'

    expect(page).to have_content 'Ordem de serviço encerrada com sucesso.'
    expect(page).to have_content DateTime.now.utc.to_s
    expect(page).to have_content 'Motivo do Atraso:'
    expect(page).to have_content 'Status: Encerrada'
  end

  it 'em atraso e sem preencher o campo Motivo do Atraso' do 
    shipping_method = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 10, maximum_distance: 30, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    vehicle = Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method)
    PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method)
    PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5, shipping_method: shipping_method)
    DeliveryTime.create!(minimum_distance:0, maximum_distance:100, deadline_in_hours: 48, shipping_method: shipping_method)
    service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                                           weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                                           email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                                           total_distance: 15, total_delivery_value: 22.5, deadline: 48, shipping_method: shipping_method, status: 'started', vehicle: vehicle, start_date: 5.days.ago)
    regular = User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

    login_as regular
    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.service_order_code
    fill_in 'Motivo do Atraso', with: ''
    click_on 'Encerrar Ordem de Serviço'

    expect(page).to have_content 'Ordem de serviço não pode ser encerrada.'
    expect(page).to have_content 'Motivo do Atraso não pode ficar em branco.'
  end
end