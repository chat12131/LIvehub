require "rails_helper"

RSpec.describe "Artists" do
  let!(:user) { create(:user) }
  let!(:artist) { create(:artist, user:) }

  before do
    sign_in user
    visit artists_path
  end

  it "アーティストが正しく表示されること" do
    expect(page).to have_content(artist.name)
  end

  it "新規アーティスト作成へのリンクが存在すること" do
    click_link "新規アーティスト作成"
    expect(page).to have_current_path(new_artist_path)
  end

  it "お気に入りへのリンクが正しいこと" do
    click_link "お気に入り"
    expect(page).to have_current_path(favorites_artists_path)
  end

  it "編集ボタンが正しく機能すること" do
    click_link "編集"
    expect(page).to have_current_path(edit_artist_path(artist))
  end

  it "削除ボタンが存在する", :js do
    expect(page).to have_selector(".btn-danger")
    find(".btn-danger").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_current_path artists_path
    expect(page).not_to have_content(artist.name)
  end
end
