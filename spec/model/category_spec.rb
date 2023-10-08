require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { build(:category) }

  describe '関連性' do
    it { should have_many(:goods).dependent(:nullify) }
    it { should belong_to(:user).optional }
  end

  describe 'バリデーション' do
    it { should validate_length_of(:name).is_at_most(15).with_message("は15文字以内で入力してください。") }
  end
end
