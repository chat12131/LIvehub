require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe "#days_since" do
    it "指定された日付から正しい日付が返されること" do
      date = Time.zone.today - 5.days
      expect(helper.days_since(date)).to eq(5)
    end

    it "当日の場合に0が返されること" do
      date = Time.zone.today
      expect(helper.days_since(date)).to eq(0)
    end
  end
end
