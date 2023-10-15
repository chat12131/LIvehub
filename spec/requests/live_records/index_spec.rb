require "rails_helper"

RSpec.describe "LiveRecords" do
  describe "GET /index" do
    let(:user) { create(:user) }
    let!(:tomorrow_live_record) do
      live_record = build(:live_record, user: user, date: Date.tomorrow, name: "Future Live Event")
      live_record.save(validate: false)
      live_record
    end

    let!(:yesterday_live_record) { create(:live_record, user: user, date: Date.yesterday, name: "Past Live Event") }

    before do
      sign_in user
      get live_records_path
    end

    it "レスポンスが正しく返されること" do
      expect(response).to be_successful
    end

    it "レスポンスに「新規作成」のリンクが含まれていること" do
      expect(response.body).to include "新規作成"
    end

    it "レスポンスに過去のライブ記録の名前が含まれていること" do
      expect(response.body).to include yesterday_live_record.name
    end

    it "レスポンスに未来のライブ記録の名前が含まれていないこと" do
      expect(response.body).not_to include tomorrow_live_record.name
    end
  end
end
