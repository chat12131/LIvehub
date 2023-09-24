require 'rails_helper'

RSpec.describe "Artists" do
  let(:user) { create(:user) }
  let(:artist) { create(:artist, user:) }

  before do
    sign_in user
    visit artist_path(artist)
  end

  it "アーティストの名前が正しく表示されること" do
    expect(page).to have_content artist.name
  end

  it "アーティストのニックネームが正しく表示されること" do
    expect(page).to have_content artist.nickname
  end

  it "アーティストのジャンルが正しく表示されること" do
    expect(page).to have_content artist.genre
  end

  it "アーティストの結成日が正しく表示されること" do
    expect(page).to have_content artist.founding_date
  end

  it "アーティストの初めて見た日が正しく表示されること" do
    expect(page).to have_content artist.first_show_date
  end

  it "アーティストのメモが正しく表示されること" do
    expect(page).to have_content artist.memo
  end

  it "お気に入りのトグルアイコンが表示されていること" do
    expect(page).to have_selector '.fa-heart'
  end

  it "編集と削除のボタンが存在すること" do
    expect(page).to have_selector '.fa-edit'
    expect(page).to have_selector '.fa-trash-alt'
  end

  it "お気に入りのトグルが機能すること", :js do
    find('.fa-heart').click
    expect(page).to have_selector '.heart-pink'
  end
end
