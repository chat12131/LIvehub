require 'rails_helper'

RSpec.describe LiveSchedule, type: :model do
  let(:user) { create(:user) }
  let(:live_schedule) { build(:live_schedule, user: user) }

  describe 'バリデーション' do
    subject(:live) { live_schedule.valid? }

    context '有効な属性の場合' do
      it 'バリデーションが通る' do
        expect(live).to be(true)
      end
    end

    context '日付が過去の場合' do
      it 'バリデーションに失敗する' do
        live_schedule.date = Date.yesterday
        expect(live).to be(false)
      end
    end

    context 'チケットの発売日が今日より前の場合' do
      it 'バリデーションに失敗する' do
        live_schedule.ticket_sale_date = Date.yesterday
        expect(live).to be(false)
      end
    end

    context 'チケットの発売日がライブの日付より後の場合' do
      it 'バリデーションに失敗する' do
        live_schedule.date = Date.tomorrow
        live_schedule.ticket_sale_date = Date.tomorrow + 1.day
        expect(live).to be(false)
      end
    end

    context 'チケット代が0より小さい場合' do
      it 'バリデーションに失敗する' do
        live_schedule.ticket_price = -1
        expect(live).to be(false)
      end
    end

    context 'ドリンク代が0より小さい場合' do
      it 'バリデーションに失敗する' do
        live_schedule.drink_price = -1
        expect(live).to be(false)
      end
    end
  end
end
