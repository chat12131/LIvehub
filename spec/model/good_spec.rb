require 'rails_helper'

RSpec.describe Good, type: :model do
  describe 'validations' do
    it 'validates presence of quantity' do
      good = described_class.new(quantity: nil)
      expect(good).not_to be_valid
    end

    it 'validates length of name' do
      good = described_class.new(name: 'a' * 16)
      expect(good).not_to be_valid
      expect(good.errors[:name]).to include("は15文字以内で入力してください。")
    end
  end
end
