require "rails_helper"

RSpec.describe "Artists" do
  let(:user) { create(:user) }
  let(:artist) { create(:artist, user:) }
  let!(:members) { create_list(:member, 3, artist: artist) }

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
    expect(page).to have_selector ".fa-heart"
  end

  it "編集と削除のボタンが存在すること" do
    expect(page).to have_selector ".fa-edit"
    expect(page).to have_selector ".fa-trash-alt"
  end

  it "お気に入りのトグルが機能すること", :js do
    find(".fa-heart").click
    expect(page).to have_selector ".heart-pink"
    visit favorites_artists_path
    expect(page).to have_content artist.name
  end

  context "メンバーがいる場合" do
    it "メンバーを表示が表示されることk" do
      expect(page).to have_content "メンバーを表示+"
    end

    it "メンバーを表示をクリックするとメンバーが表示されること", :js do
      click_on "メンバーを表示+"
      members.each do |member|
        expect(page).to have_content member.name
      end
    end

    it "メンバー削除ボタンで削除できること", :js do
      member_name = members.first.name
      click_on "メンバーを表示+"
      within "#member_#{members.first.id}" do
        accept_alert do
          find(".fas.fa-trash-alt").click
        end
      end
      expect(page).not_to have_content(member_name)
    end
  end

  context "メンバーがいない場合" do
    it "メンバーを表示が表示されないこと" do
      artist.members.destroy_all
      visit artist_path(artist)
      expect(page).not_to have_content "メンバーを表示+"
    end
  end
end
