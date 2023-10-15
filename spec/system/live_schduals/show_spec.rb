require 'rails_helper'

RSpec.describe "LiveSchedule Details" do
  let(:user) { create(:user) }
  let(:live_schedule) { create(:live_schedule, user: user) }

  before do
    sign_in user
    visit live_schedule_path(live_schedule)
  end

  it "ライブ予定詳細の基本情報が表示される" do
    expect(page).to have_content(live_schedule.name)
    expect(page).to have_content(live_schedule.artist.display_name)
    expect(page).to have_content(live_schedule.venue.name)
  end

  it "ライブ予定詳細の日時・チケット情報が表示される" do
    expect(page).to have_content(live_schedule.date)
    expect(page).to have_content(live_schedule.open_time.strftime("%H:%M"))
    expect(page).to have_content(live_schedule.ticket_status.humanize)
  end

  it "メモの情報が表示される" do
    expect(page).to have_content(live_schedule.memo)
  end

  it "編集ボタンが存在する", :js do
    expect(page).to have_selector(".fa-edit")
    find(".fa-edit", visible: true).click
    sleep 2

    expect(page).to have_current_path edit_live_schedule_path(live_schedule)
  end

  it "削除ボタンが存在する", :js do
    expect(page).to have_selector(".fa-trash")
    find(".fa-trash").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_current_path live_schedules_path
  end

  it "Google Mapリンクが存在し、正しいURLを持っている" do
    google_map_link = "https://www.google.com/maps/search/#{live_schedule.venue.name}"
    expect(page).to have_link(href: google_map_link)
  end

  it "天気予報が表示されること", :js do
    expect(page).to have_content("降水確率")
  end

  it "日付が10日後の場合は表示されないこと", :js do
    live_schedule.date = Time.zone.today + 10.days
    expect(page).not_to have_content("降水確率")
  end

  it "緯度経度が空なら表示されないこと", :js do
    live_schedule.venue.update(latitude: nil, longitude: nil)
    expect(page).not_to have_content("降水確率")
  end

end
