require 'rails_helper'

RSpec.describe "LiveRecords", :js do
  describe "ライブ記録の編集" do
    let(:user) { create(:user) }
    let(:artist) { FactoryBot.create(:artist, user: user) }
    let(:venue) { FactoryBot.create(:venue, user: user) }
    let(:live_record) { FactoryBot.create(:live_record, user: user, artist: artist, venue: venue) }

    before do
      sign_in user
      visit edit_live_record_path(live_record)
    end

    it "正常に編集されること" do
      fill_in "イベント名", with: "新しいイベント名"
      execute_script("window.scrollBy(0,10000)")
      click_button "登録"

      expect(page).to have_current_path live_records_path
      expect(page).to have_content "新しいイベント名"
    end

    it "正常に編集されること" do
      fill_in "イベント名", with: "新しいイベント名"
      find_by_id('venue-name-display').set("")
      execute_script("window.scrollBy(0,10000)")
      click_button "登録"

      expect(page).to have_content("保存されませんでした")
    end

    it "正しい情報が入力、選択されていること", :js do
      expect(page).to have_field('live_record_name', with: live_record.name)
      expect(page).to have_select('live_record_artist_id', selected: artist.display_name)
      expect(page).to have_field('live_record_date', with: live_record.date)
      expect(page).to have_field('live_record_start_time', with: live_record.start_time.strftime('%H:%M'))
      expect(page).to have_field('venue-name-display', with: venue.name)
    end

    it "チケットとメモが表示されること", :js do
      execute_script("window.scrollBy(0,1000)")
      expect(page).to have_field('ticket_price_input', with: live_record.ticket_price)
      expect(page).to have_field('live_record_drink_price', with: live_record.drink_price)
      expect(page).to have_field('live_record_memo', with: live_record.memo)
    end

    it "新しいアーティストを追加のリンクをクリックすると新しいアーティストのページへ遷移すること", :js do
      click_link "新しいアーティストを追加"
      expect(page).to have_current_path("/artists/new", ignore_query: true)
    end
  end
end
