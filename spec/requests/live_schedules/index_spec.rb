require 'rails_helper'

RSpec.describe "LiveSchedules" do
  describe "GET /index" do
    let(:user) { create(:user) }
    let!(:past_live_schedule) do
      live_schedule = build(:live_schedule, user: user, date: Date.yesterday - 2, name: "Past Live Event")
      live_schedule.save(validate: false)
      live_schedule
    end
    let!(:upcoming_live_schedule) { create(:live_schedule, user: user, date: Date.tomorrow) }

    before do
      sign_in user
      get live_schedules_path
    end

    it 'レスポンスが正しく返されること' do
      expect(response).to be_successful
    end

    it "過去のライブスケジュールは表示されない" do
      expect(assigns(:live_schedules)).not_to include(past_live_schedule)
    end

    it "今後のライブスケジュールは表示される" do
      expect(assigns(:live_schedules)).to include(upcoming_live_schedule)
    end

    it 'レスポンスに「新規作成」のリンクが含まれていること' do
      expect(response.body).to include '新規作成'
    end

    it 'レスポンスに今後のライブスケジュールの名前が含まれていること' do
      expect(response.body).to include upcoming_live_schedule.name
    end

    it 'レスポンスに過去のライブスケジュールの名前が含まれていないこと' do
      expect(response.body).not_to include past_live_schedule.name
    end
  end
end
