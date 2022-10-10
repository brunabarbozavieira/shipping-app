require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do 
    it 'nome é obrigatório' do 
      user = User.new(name: '')
      user.valid?
      expect(user.errors.include? :name).to eq true
    end
  end
end
