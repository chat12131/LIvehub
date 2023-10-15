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

  it "開始時間が表示される" do
    expect(page).to have_content(live_record.start_time.strftime("%H:%M")) if live_record.start_time.present?
  end

  it "チケット代が表示される" do
    expect(page).to have_content(live_record.ticket_price) if live_record.ticket_price.present?
  end

  it "ドリンク代が表示される" do
    expect(page).to have_content(live_record.drink_price) if live_record.drink_price.present?
  end

  it "メモの情報が表示される" do
    expect(page).to have_content(live_record.memo)
  end

  it "編集ボタンが存在する", :js do
    expect(page).to have_selector(".fa-edit")
    find(".fa-edit", visible: true).click
    sleep 2

    expect(page).to have_current_path edit_live_record_path(live_record)
  end

  it "削除ボタンが存在する", :js do
    expect(page).to have_selector(".fa-trash")
    find(".fa-trash").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_current_path live_records_path
  end

  it "Google Mapリンクが存在し、正しいURLを持っている" do
    google_map_link = "https://www.google.com/maps/search/#{live_record.venue.name}"
    expect(page).to have_link(href: google_map_link)
  end

  it "クリックすると正しいグッズの新規作成ページへ遷移する" do
    click_link 'グッズ'
    expected_url = "http://www.example.com#{new_good_path(live_record_id: live_record.id)}"
    expect(page).to have_current_path(expected_url, url: true)
  end
end
