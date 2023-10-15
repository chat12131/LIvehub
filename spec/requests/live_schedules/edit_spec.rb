require "rails_helper"

RSpec.describe "LiveSchedules", :js do
  let!(:user) { create(:user) }
  let!(:venue) { create(:venue, user: user) }
  let!(:live_schedule) { create(:live_schedule, user: user, venue: venue) }

  before do
    sign_in user
    get edit_live_schedule_path(live_schedule)
  end

  it "レスポンスが正しく返されること" do
    expect(response).to be_successful
  end

  describe "スケジュールの編集" do
    it "編集されること" do
      patch live_schedule_path(live_schedule), params: {
        live_schedule: {
          name: "新しいイベント名",
          venue_attributes: {
            name: venue.name, google_place_id: venue.google_place_id
          }
        }
      }

      expect(response).to redirect_to live_schedules_path
      expect(live_schedule.reload.name).to eq "新しいイベント名"
    end
  end
end
