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
end
