require "rails_helper"

RSpec.describe "LiveSchedules", :js do
  describe "ライブスケジュールの編集" do
    let!(:user) { create(:user) }
    let(:artist) { FactoryBot.create(:artist, user: user) }
    let(:venue) { FactoryBot.create(:venue, user: user) }
    let(:live_schedule) { FactoryBot.create(:live_schedule, user: user, artist: artist, venue: venue) }

    before do
      sign_in user
      visit edit_live_schedule_path(live_schedule)
    end

    it "正常に編集されること" do
      fill_in "イベント名", with: "新しいイベント名"
      find_by_id("venue-name-display").set("新しい")
      execute_script("window.scrollBy(0,10000)")
      click_button "登録"

      expect(page).to have_current_path live_schedules_path
      expect(page).to have_content "新しいイベント名"
    end

    it "必須が空だと保存されないこと" do
      execute_script("document.querySelector('#live_schedule_date').value = ''")
      find_by_id("venue-name-display").set("")
      execute_script("window.scrollBy(0,10000)")
      click_button "登録"

      expect(page).to have_content("保存されませんでした")
    end

    it "正しい情報が入力、選択されていること", :js do
      expect(page).to have_field("live_schedule_name", with: live_schedule.name)
      expect(page).to have_select("live_schedule_artist_id", selected: artist.display_name)
      expect(page).to have_field("live_schedule_date", with: live_schedule.date)
      expect(page).to have_field("live_schedule_open_time", with: live_schedule.open_time.strftime("%H:%M"))
      expect(page).to have_field("live_schedule_start_time", with: live_schedule.start_time.strftime("%H:%M"))
      expect(page).to have_field("venue-name-display", with: venue.name)
      execute_script("window.scrollBy(0,1000)")
      expect(page).to have_checked_field "購入済", visible: false
    end

    it "チケットとメモが表示されること", :js do
      live_schedule.update(ticket_status: 0)
      visit edit_live_schedule_path(live_schedule)
      execute_script("window.scrollBy(0,1000)")
      expect(page).to have_field("live_schedule_ticket_sale_date", with: live_schedule.ticket_sale_date)
      expect(page).to have_field("ticket_price_input", with: live_schedule.ticket_price)
      expect(page).to have_field("live_schedule_drink_price", with: live_schedule.drink_price)
      expect(page).to have_field("live_schedule_memo", with: live_schedule.memo)
    end

    it "新しいアーティストを追加のリンクをクリックすると新しいアーティストのページへ遷移すること", :js do
      click_link "新しいアーティストを追加"
      expect(page).to have_current_path("/artists/new", ignore_query: true)
    end
  end
end
