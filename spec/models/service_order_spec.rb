require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  describe '#valid?' do 
    it 'endereço de retirada é obrigatório' do 
      service_order = ServiceOrder.new(initial_full_address: '')
      service_order.valid?

      expect(service_order.errors.include? :initial_full_address).to eq true
    end

    it 'código do produto é obrigatório' do 
      service_order = ServiceOrder.new(product_code: '')
      service_order.valid?

      expect(service_order.errors.include? :product_code).to eq true
    end

    it 'dimensões é obrigatório' do 
      service_order = ServiceOrder.new(dimensions: '')
      service_order.valid?

      expect(service_order.errors.include? :dimensions).to eq true
    end

    it 'peso é obrigatório' do 
      service_order = ServiceOrder.new(weight: '')
      service_order.valid?

      expect(service_order.errors.include? :weight).to eq true
    end

    it 'nome do destinatário é obrigatório' do 
      service_order = ServiceOrder.new(recipient_name: '')
      service_order.valid?

      expect(service_order.errors.include? :recipient_name).to eq true
    end

    it 'CPF é obrigatório' do 
      service_order = ServiceOrder.new(identification_document: '')
      service_order.valid?

      expect(service_order.errors.include? :identification_document).to eq true
    end

    it 'telefone é obrigatório' do 
      service_order = ServiceOrder.new(contact_phone: '')
      service_order.valid?

      expect(service_order.errors.include? :contact_phone).to eq true
    end

    it 'E-mail é obrigatório' do 
      service_order = ServiceOrder.new(email: '')
      service_order.valid?

      expect(service_order.errors.include? :email).to eq true
    end

    it 'endereço para entrega é obrigatório' do 
      service_order = ServiceOrder.new(full_delivery_address: '')
      service_order.valid?

      expect(service_order.errors.include? :full_delivery_address).to eq true
    end

    it 'distância total é obrigatório' do 
      service_order = ServiceOrder.new(total_distance: '')
      service_order.valid?

      expect(service_order.errors.include? :total_distance).to eq true
    end

    it 'status é obrigatório' do 
      service_order = ServiceOrder.new(status: '')
      service_order.valid?

      expect(service_order.errors.include? :status).to eq true
    end

    it 'código da ordem de serviço é obrigatório' do 
      service_order = ServiceOrder.new(service_order_code: '')
      service_order.valid?

      expect(service_order.errors.include? :service_order_code).to eq false
    end
  end

  describe 'Gera um código aleatório' do 
    it 'ao criar uma nova ordem de serviço' do 
      service_order = ServiceOrder.new(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '5T85YHT78EI56BD', dimensions: '104cm x 54cm x 61cm', 
                          weight: 32, recipient_name: 'Rosa de Souza Melo', identification_document: '10328832006', contact_phone: '11988880000', 
                          email: 'rosasm@email.com.br', full_delivery_address: 'Rua Frida Kahlo, 257 - Jundiaí - SP', total_distance: 60)
      service_order.save!
      
      expect(service_order.service_order_code).not_to be_empty
      expect(service_order.service_order_code.length).to eq 15
    end
    
    it 'e tem que ser único' do 
      first_service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '5T85YHT78EI56BD', dimensions: '104cm x 54cm x 61cm', 
                                                  weight: 32, recipient_name: 'Rosa de Souza Melo', identification_document: '10328832006', contact_phone: '11988880000', 
                                                  email: 'rosasm@email.com.br', full_delivery_address: 'Rua Frida Kahlo, 257 - Jundiaí - SP', total_distance: 60)
      second_service_order = ServiceOrder.new(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                                                  weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                                                  email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP', total_distance: 15)

      second_service_order.save!

      expect(second_service_order.service_order_code).not_to eq first_service_order.service_order_code
    end
  end

  describe 'filtra modalidade de frete' do 
    it 'e retorna apenas as que atendem a ordem de serviço' do 
      shipping_method_a = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 10, maximum_distance: 30, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
      shipping_method_b = ShippingMethod.create!(name: 'itens Grandes', minimum_distance: 20, maximum_distance: 500, minimum_weight: 50, maximum_weight: 500, flat_rate: 32)
      shipping_method_c = ShippingMethod.create!(name: 'Turbo', minimum_distance: 0, maximum_distance: 20, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
      service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                                           weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                                           email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                                           total_distance: 15)

      expect(service_order.options_shipping_method).to eq [shipping_method_a,shipping_method_c]
    end

    it 'e retorna o prazo de cada uma' do 
      shipping_method_a = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 10, maximum_distance: 30, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
      delivery_time_a = DeliveryTime.create!(minimum_distance:0, maximum_distance:100, deadline_in_hours: 48, shipping_method: shipping_method_a)
      service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                                           weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                                           email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                                           total_distance: 15)

      expect(service_order.due_date(shipping_method_a)).to eq delivery_time_a.deadline_in_hours
    end

    it 'e retorna um preço por peso para cada uma' do 
      shipping_method_a = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 10, maximum_distance: 30, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
      price_by_weight_a = PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5, shipping_method: shipping_method_a)
      service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                                           weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                                           email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                                           total_distance: 15)

      expect(service_order.price_by_weight_for_each_shipping_method_options(shipping_method_a)).to eq price_by_weight_a.price_per_kilometer * service_order.total_distance
    end

    it 'e retorna um preço por distância para cada uma' do 
      shipping_method_a = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 10, maximum_distance: 30, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
      price_by_distance_a = PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method_a)
      service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                                           weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                                           email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                                           total_distance: 15)

      expect(service_order.price_by_distance_for_each_shipping_method_options(shipping_method_a)).to eq price_by_distance_a.rate
    end

    it 'e retorna um preço por distância para cada uma' do 
      shipping_method_a = ShippingMethod.create!(name: 'Super Veloz', minimum_distance: 10, maximum_distance: 30, minimum_weight: 0, maximum_weight: 20, flat_rate: 6)
      price_by_distance_a = PriceByDistance.create!(minimum_distance: 0, maximum_distance: 50, rate: 9, shipping_method: shipping_method_a)
      price_by_weight_a = PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5, shipping_method: shipping_method_a)
      service_order = ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                                           weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                                           email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                                           total_distance: 15)

      expect(service_order.total_price_service_order(shipping_method_a)).to eq 22.5
    end
  end
end
