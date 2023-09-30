require 'rails_helper'

RSpec.describe "LiveRecord Details" do
  let(:user) { create(:user) }
  let(:live_record) { create(:live_record, user: user) }

  before do
    sign_in user
    visit live_record_path(live_record)
  end

  it "ライブ記録詳細の基本情報が表示される" do
    expect(page).to have_content(live_record.name)
    expect(page).to have_content(live_record.artist.display_name)
    expect(page).to have_content(live_record.venue.name)
  end

  it "ライブ記録詳細の日時が表示される" do
    expect(page).to have_content(live_record.date)
  end

  it "メモの情報が表示される" do
    expect(page).to have_content(live_record.memo)
  end

  it "編集ボタンが存在する", :js do
    expect(page).to have_selector(".fa-edit")
    find(".fa-edit", visible: true).click
    sleep 2

    expect(page).to have_current_path edit_live_record_path(live_record), ignore_query: true
  end

  it "削除ボタンが存在する", :js do
    expect(page).to have_selector(".fa-trash")
    find(".fa-trash").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_current_path live_records_path, ignore_query: true
  end

  it "Google Mapリンクが存在し、正しいURLを持っている" do
    google_map_link = "https://www.google.com/maps/search/#{live_record.venue.name}"
    expect(page).to have_link(href: google_map_link)
  end
end
