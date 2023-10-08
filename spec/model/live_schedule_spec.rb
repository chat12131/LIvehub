require 'rails_helper'

RSpec.describe LiveSchedule, type: :model do
  describe 'バリデーション' do
    subject(:live_schedule) { build(:live_schedule, user: create(:user)) }

    it { should validate_presence_of(:date) }
    it { should validate_numericality_of(:ticket_price).is_greater_than_or_equal_to(0).with_message("はマイナスの値を設定できません。").allow_nil }
    it { should validate_numericality_of(:drink_price).is_greater_than_or_equal_to(0).with_message("はマイナスの値を設定できません。").allow_nil }
    it { should validate_length_of(:memo).is_at_most(300).with_message("は300文字以内で入力してください。") }

    it '日付が過去の場合、バリデーションに失敗する' do
      live_schedule.date = Date.yesterday
      expect(live_schedule).not_to be_valid
    end

    it 'チケットの発売日が今日より前の場合、バリデーションに失敗する' do
      live_schedule.ticket_sale_date = Date.yesterday
      expect(live_schedule).not_to be_valid
    end

    it 'チケットの発売日がライブの日付より後の場合、バリデーションに失敗する' do
      live_schedule.date = Date.tomorrow
      live_schedule.ticket_sale_date = Date.tomorrow + 1.day
      expect(live_schedule).not_to be_valid
    end

    it 'チケット代が0より小さい場合、バリデーションに失敗する' do
      live_schedule.ticket_price = -1
      expect(live_schedule).not_to be_valid
    end

    it 'ドリンク代が0より小さい場合、バリデーションに失敗する' do
      live_schedule.drink_price = -1
      expect(live_schedule).not_to be_valid
    end
  end

  describe '関連性' do
    it { should belong_to(:artist).optional }
    it { should belong_to(:venue) }
    it { should belong_to(:user) }
    it { should accept_nested_attributes_for(:venue) }
  end
end
