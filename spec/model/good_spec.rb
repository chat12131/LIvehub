require "rails_helper"

RSpec.describe Good, type: :model do
  describe "関連性" do
    it { should belong_to(:user) }
    it { should belong_to(:live_record).optional }
    it { should belong_to(:artist).optional }
    it { should belong_to(:member).optional }
    it { should belong_to(:category) }
  end

  describe "バリデーション" do
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0).with_message("はマイナスの値を設定できません。").allow_nil }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(1).with_message("は1以上を設定してください。") }
    it { should validate_length_of(:name).is_at_most(15).with_message("は15文字以内で入力してください。") }

    context "未来の日付のバリデーション" do
      subject(:good) { build(:good, date: Date.tomorrow, category: create(:category)) }

      it "未来の日付は設定できないこと" do
        expect(good).not_to be_valid
        expect(good.errors.messages[:date]).to include("は未来の日付を設定することはできません。")
      end
    end
  end
end
