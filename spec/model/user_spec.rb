require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:artists).dependent(:destroy) }
    it { should have_many(:live_schedules).dependent(:destroy) }
    it { should have_many(:live_records).dependent(:destroy) }
    it { should have_many(:venues).dependent(:destroy) }
    it { should have_many(:goods).dependent(:destroy) }
    it { should have_many(:categories).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_length_of(:username).is_at_most(10) }
  end

  describe ".guest" do
    it "ゲストユーザーが返されること" do
      guest = User.guest
      expect(guest.username).to eq "ゲスト"
      expect(guest.email).to eq "guest@example.com"
    end

    it "ゲストが存在しない時に作成されること" do
      expect { User.guest }.to change { User.count }.by(1)
    end

    it "ゲストが存在する場合は作成されないこと" do
      User.create!(username: "ゲスト", email: "guest@example.com", password: "password")
      expect { User.guest }.not_to change { User.count }
    end
  end
end
