require 'rails_helper'

RSpec.describe PriceByDistance, type: :model do
  describe '#valid?' do 
    it 'distância mínima é obrigatório' do 
      price_by_distance = PriceByDistance.new(minimum_distance: '')

      price_by_distance.valid?
  
      expect(price_by_distance.errors.include? :minimum_distance).to eq true 
    end

    it 'distância máxima é obrigatório' do 
      price_by_distance = PriceByDistance.new(maximum_distance: '')

      price_by_distance.valid?
  
      expect(price_by_distance.errors.include? :maximum_distance).to eq true 
    end

    it 'taxa é obrigatório' do 
      price_by_distance = PriceByDistance.new(rate: '')

      price_by_distance.valid?
  
      expect(price_by_distance.errors.include? :rate).to eq true 
    end
  end
end
