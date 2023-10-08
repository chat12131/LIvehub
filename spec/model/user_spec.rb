require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:artists).dependent(:destroy) }
    it { should have_many(:live_schedules).dependent(:destroy) }
    it { should have_many(:live_records).dependent(:destroy) }
    it { should have_many(:venues).dependent(:destroy) }
    it { should have_many(:goods).dependent(:destroy) }
    it { should have_many(:categories).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_length_of(:username).is_at_most(10) }
  end

  describe '.guest' do
    it 'returns a guest user' do
      guest = User.guest
      expect(guest.username).to eq 'ゲスト'
      expect(guest.email).to eq 'guest@example.com'
    end

    it 'creates a new guest user if one does not already exist' do
      expect { User.guest }.to change { User.count }.by(1)
    end

    it 'does not create a new guest user if one already exists' do
      User.create!(username: 'ゲスト', email: 'guest@example.com', password: 'password')
      expect { User.guest }.not_to change { User.count }
    end
  end
end
