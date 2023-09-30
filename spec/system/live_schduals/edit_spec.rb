require 'rails_helper'

RSpec.describe "LiveSchedules", :js do
  describe "ライブスケジュールの編集" do
    let(:user) { create(:user) }
    let!(:live_schedule) { create(:live_schedule, user: user) }

    before do
      sign_in user
      visit edit_live_schedule_path(live_schedule)
    end

    it "正常に編集されること" do
      fill_in "イベント名", with: "新しいイベント名"
      execute_script("window.scrollBy(0,10000)")
      click_button "登録"

      expect(page).to have_current_path live_schedules_path, ignore_query: true
      expect(page).to have_content "新しいイベント名"
    end
  end
end
