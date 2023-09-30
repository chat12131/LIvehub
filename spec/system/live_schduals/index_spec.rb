require 'rails_helper'

RSpec.describe "LiveSchedules Index" do
  let(:user) { create(:user) }
  let!(:upcoming_live_schedule) { create(:live_schedule, user: user, date: Date.tomorrow) }

  before do
    sign_in user
    visit live_schedules_path
  end

  it "今後のライブスケジュールの名前とアーティストが一覧に表示される" do
    expect(page).to have_content(upcoming_live_schedule.name)
    expect(page).to have_content(upcoming_live_schedule.artist.display_name)
  end

  it "会場名と開門時間が一覧に表示される" do
    expect(page).to have_content(upcoming_live_schedule.venue.name)
    expect(page).to have_content(upcoming_live_schedule.open_time.strftime("%H:%M"))
  end

  it "開始時間が一覧に表示される" do
    expect(page).to have_content(upcoming_live_schedule.start_time.strftime("%H:%M"))
  end

  it "新規作成ボタンが表示される" do
    expect(page).to have_link("新規作成", href: new_live_schedule_path)
  end
end
