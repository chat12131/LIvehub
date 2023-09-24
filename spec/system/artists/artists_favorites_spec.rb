require 'rails_helper'

RSpec.describe "Artists" do
  let!(:user) { create(:user) }
  let!(:favorite_artist) { create(:artist, user:, favorited: true) }
  let!(:non_favorite_artist) { create(:artist, :non_favorite_artist_name_only, user:) }

  before do
    sign_in user
    visit favorites_artists_path
  end

  it "お気に入りのアーティストが表示されること" do
    expect(page).to have_content favorite_artist.name
  end

  it "非お気に入りのアーティストが表示されないこと" do
    expect(page).not_to have_content non_favorite_artist.name
  end

  it "新規アーティスト作成のリンクが存在すること" do
    expect(page).to have_link("新規アーティスト作成", href: new_artist_path)
  end

  it "全アーティスト一覧のリンクが存在すること" do
    expect(page).to have_link("全アーティスト一覧", href: artists_path)
  end
end
