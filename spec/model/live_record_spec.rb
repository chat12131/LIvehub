require "rails_helper"

RSpec.describe LiveRecord, type: :model do
  describe "バリデーション" do
    subject(:live_record) { build(:live_record) }

    it { should validate_presence_of(:date) }
    it { should validate_numericality_of(:ticket_price).is_greater_than_or_equal_to(0).with_message("はマイナスの値を設定できません。").allow_nil }
    it { should validate_numericality_of(:drink_price).is_greater_than_or_equal_to(0).with_message("はマイナスの値を設定できません。").allow_nil }
    it { should validate_length_of(:memo).is_at_most(300).with_message("は300文字以内で入力してください。") }

    context "未来の日付の場合" do
      it "無効であること" do
        live_record.date = Time.zone.tomorrow
        expect(live_record).not_to be_valid
      end
    end
  end

  describe "関連性" do
    it { should have_many(:goods).dependent(:nullify) }
    it { should belong_to(:artist).optional }
    it { should belong_to(:venue) }
    it { should belong_to(:user) }
  end
end
