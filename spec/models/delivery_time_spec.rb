require 'rails_helper'

RSpec.describe DeliveryTime, type: :model do
  describe '#valid?' do 
    it 'distância mínima é obrigatório' do 
      delivery_time = DeliveryTime.new(minimum_distance: '')

      delivery_time.valid?
  
      expect(delivery_time.errors.include? :minimum_distance).to eq true 
    end

    it 'distância máxima é obrigatório' do 
      delivery_time = DeliveryTime.new(maximum_distance: '')

      delivery_time.valid?
  
      expect(delivery_time.errors.include? :maximum_distance).to eq true 
    end

    it 'prazo em horas é obrigatorio' do 
      delivery_time = DeliveryTime.new(deadline_in_hours: '')

      delivery_time.valid?
  
      expect(delivery_time.errors.include? :deadline_in_hours).to eq true 
    end
  end
end
