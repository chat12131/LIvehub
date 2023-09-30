require 'rails_helper'

RSpec.describe LiveRecord, type: :model do
  describe 'バリデーション' do
    let(:live_record) { build(:live_record) }

    it '有効な属性値の場合、有効であること' do
      expect(live_record).to be_valid
    end

    it '日付がない場合、無効であること' do
      live_record.date = nil
      expect(live_record).not_to be_valid
    end

    it '未来の日付の場合、無効であること' do
      live_record.date = Time.zone.tomorrow
      expect(live_record).not_to be_valid
    end

    it 'チケット代がマイナスの場合、無効であること' do
      live_record.ticket_price = -10
      expect(live_record).not_to be_valid
    end

    it 'ドリンク代がマイナスの場合、無効であること' do
      live_record.drink_price = -5
      expect(live_record).not_to be_valid
    end

    it 'メモが301文字以上の場合、無効であること' do
      live_record.memo = 'あ' * 301
      expect(live_record).not_to be_valid
    end
  end
end
