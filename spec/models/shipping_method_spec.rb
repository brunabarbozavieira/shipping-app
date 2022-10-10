require 'rails_helper'

RSpec.describe ShippingMethod, type: :model do
  describe '#valid?' do 
  context 'campo obrigatório' do 
    it 'nome é obrigatório' do 
      shipping_method = ShippingMethod.new(name: '')

      shipping_method.valid?

     expect(shipping_method.errors.include? :name).to eq true 
    end

    it 'distância mínima é obrigatório' do 
      shipping_method = ShippingMethod.new(minimum_distance: '')

      shipping_method.valid?

     expect(shipping_method.errors.include? :minimum_distance).to eq true 
    end

    it 'distância máxima é obrigatório' do 
      shipping_method = ShippingMethod.new(maximum_distance: '')

      shipping_method.valid?

     expect(shipping_method.errors.include? :maximum_distance).to eq true 
    end

    it 'peso mínimo é obrigatório' do 
      shipping_method = ShippingMethod.new(minimum_weight: '')

      shipping_method.valid?

     expect(shipping_method.errors.include? :minimum_weight).to eq true 
    end

    it 'peso máximo é obrigatório' do 
      shipping_method = ShippingMethod.new(maximum_weight: '')

      shipping_method.valid?

     expect(shipping_method.errors.include? :maximum_weight).to eq true 
    end

    it 'taxa fixa é obrigatório' do 
      shipping_method = ShippingMethod.new(flat_rate: '')

      shipping_method.valid?

     expect(shipping_method.errors.include? :flat_rate).to eq true 
    end
  end
end
end
