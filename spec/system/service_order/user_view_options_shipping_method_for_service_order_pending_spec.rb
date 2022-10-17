require 'rails_helper'

describe 'Usuário vê opções de modalidade de frete para ordem de serviço pendente' do 
  it 'na tela de detalhes de uma ordem de serviço' do 
    shipping_method_a = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 10, maximum_distance: 30, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
    price_by_distance_a = PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method_a)
    price_by_weight_a = PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5, shipping_method: shipping_method_a)
    delivery_time_a = DeliveryTime.create!(minimum_distance:0, maximum_distance:100, deadline_in_hours: 48, shipping_method: shipping_method_a)
    service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                                           weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                                           email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                                           total_distance: 15)

    visit root_path
    click_on 'Ordens de Serviço'
    click_on service_order.service_order_code

    expect(page).to have_content 'Escolha a Modalidade de Frete'
    expect(page).to have_content 'Nome'
    expect(page).to have_content 'Preço'
    expect(page).to have_content 'Prazo'
    expect(page).to have_content 'Super Veloz'
    expect(page).to have_content '48'
    expect(page).to have_content '22.5'
    expect(page).not_to have_content 'Itens Grandes'
  end
end