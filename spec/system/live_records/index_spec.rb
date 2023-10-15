require "rails_helper"

RSpec.describe "LiveRecords Index" do
  let(:user) { create(:user) }
  let!(:upcoming_live_record) { create(:live_record, user: user, date: Date.yesterday) }

  before do
    sign_in user
    visit live_records_path
  end

  it "今後のライブ記録の名前とアーティストが一覧に表示される" do
    expect(page).to have_content(upcoming_live_record.name)
    expect(page).to have_content(upcoming_live_record.artist.display_name)
  end

  it "会場名が一覧に表示される" do
    expect(page).to have_content(upcoming_live_record.venue.name)
  end

  it "日付が一覧に表示される" do
    expect(page).to have_content(I18n.l(upcoming_live_record.date, format: "%-m月%-d日"))
  end

  it "チケット代が一覧に表示される" do
    expect(page).to have_content("#{upcoming_live_record.ticket_price}円")
  end

  it "ドリンク代が一覧に表示される" do
    expect(page).to have_content("#{upcoming_live_record.drink_price}円")
  end

  it "会場のエリアが一覧に表示される" do
    expect(page).to have_content(upcoming_live_record.venue.area)
  end

  it "新規作成ボタンが表示される" do
    click_link "新規作成"
    expect(page).to have_current_path(new_live_record_path)
  end
end
