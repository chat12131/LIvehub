require "rails_helper"

RSpec.describe "LiveRecords" do
  let(:user) { create(:user) }
  let(:live_record) { create(:live_record, user: user) }

  describe "GET /show" do
    before do
      sign_in user
      get live_record_path(live_record)
    end

    it "正常なレスポンスが返る" do
      expect(response).to have_http_status(:success)
    end

    it "ライブ記録詳細の基本情報が正しく表示される" do
      expect(response.body).to include(live_record.name)
      expect(response.body).to include(live_record.artist.display_name)
      expect(response.body).to include(live_record.venue.name)
    end

    it "ライブ記録詳細の日時が正しく表示される" do
      expect(response.body).to include(live_record.date.to_s)
    end

    it "メモの情報が正しく表示される" do
      expect(response.body).to include(live_record.memo)
    end
  end
end
