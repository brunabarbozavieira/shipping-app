require 'rails_helper'

RSpec.describe PriceByWeight, type: :model do
  describe '#valid?' do 
    it 'peso mínimo é obrigatório' do 
      price_by_weight = PriceByWeight.new(minimum_weight: '')

      price_by_weight.valid?
  
      expect(price_by_weight.errors.include? :minimum_weight).to eq true 
    end

    it 'peso máximo é obrigatório' do 
      price_by_weight = PriceByWeight.new(maximum_weight: '')

      price_by_weight.valid?
  
      expect(price_by_weight.errors.include? :maximum_weight).to eq true 
    end

    it 'preço por km é obrigatório' do 
      price_by_weight = PriceByWeight.new(price_per_kilometer: '')

      price_by_weight.valid?
  
      expect(price_by_weight.errors.include? :price_per_kilometer).to eq true 
    end
  end
end
