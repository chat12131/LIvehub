require "rails_helper"

RSpec.describe "LiveSchedules" do
  let(:user) { create(:user) }

  describe "GET /new" do
    before do
      sign_in user
      get new_live_schedule_path
    end

    it "レスポンスが正しく返されること" do
      expect(response).to have_http_status(:success)
    end

    it "renders the form elements" do
      expect(response.body).to include("ライブ予定")
      expect(response.body).to include('name="live_schedule[name]"')
      expect(response.body).to include('name="live_schedule[date]"')
    end
  end
end
