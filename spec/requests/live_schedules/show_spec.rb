require 'rails_helper'

RSpec.describe "LiveSchedules" do
  let(:user) { create(:user) }
  let(:live_schedule) { create(:live_schedule, user: user) }

  describe "GET /show" do
    before do
      sign_in user
      get live_schedule_path(live_schedule)
    end

    it "正常なレスポンスが返る" do
      expect(response).to have_http_status(:success)
    end

    it "ライブ予定詳細の基本情報が正しく表示される" do
      expect(response.body).to include(live_schedule.name)
      expect(response.body).to include(live_schedule.artist.display_name)
      expect(response.body).to include(live_schedule.venue.name)
    end

    it "ライブ予定詳細の日時・チケット情報が正しく表示される" do
      expect(response.body).to include(live_schedule.date.to_s)
      expect(response.body).to include(live_schedule.open_time.strftime("%H:%M"))
      expect(response.body).to include(live_schedule.ticket_status.humanize)
    end

    it "メモの情報が正しく表示される" do
      expect(response.body).to include(live_schedule.memo)
    end
  end
end
