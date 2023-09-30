require 'rails_helper'

RSpec.describe "LiveRecords", :js do
  describe "ライブ記録の編集" do
    let(:user) { create(:user) }
    let!(:live_record) { create(:live_record, user: user) }

    before do
      sign_in user
      visit edit_live_record_path(live_record)
    end

    it "正常に編集されること" do
      fill_in "イベント名", with: "新しいイベント名"
      execute_script("window.scrollBy(0,10000)")
      click_button "登録"

      expect(page).to have_current_path live_records_path, ignore_query: true
      expect(page).to have_content "新しいイベント名"
    end
  end
end
