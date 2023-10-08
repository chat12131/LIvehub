require 'rails_helper'

RSpec.describe "LiveSchedules", :js do
  let!(:user) { create(:user) }
  let!(:venue) { create(:venue, user: user) }
  let!(:live_record) { create(:live_record, user: user, venue: venue) }

  before do
    sign_in user
    get edit_live_record_path(live_record)
  end

  it 'レスポンスが正しく返されること' do
    expect(response).to be_successful
  end

  describe "ライブ記録の編集" do
    it "編集されること" do
      patch live_record_path(live_record), params: {
        live_record: {
          name: "新しいイベント名",
          venue_attributes: {
            name: venue.name, google_place_id: venue.google_place_id
          }
        }
      }

      expect(response).to redirect_to live_records_path
      expect(live_record.reload.name).to eq "新しいイベント名"
    end
  end
end
