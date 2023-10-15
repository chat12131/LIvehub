require "rails_helper"

RSpec.describe "Goods", :js do
  let(:user) { create(:user) }
  let!(:artist) { create(:artist, user: user) }
  let!(:live_record) { create(:live_record, user: user, artist: artist) }
  let!(:member) { create(:member, artist: artist) }
  let!(:category) { create(:category, user: user) }
  let!(:category_other) { create(:category, user: user, name: "その他") }

  before do
    sign_in user
    visit new_good_path
  end

  it "グッズ記録が作成されること" do
    fill_in "商品名", with: "テスト商品"
    fill_in "個数", with: 10
    find_by_id("category_selector").set(category.name)
    click_on "作成"
    expect(page).to have_current_path goods_path
  end

  it "何も入力しない場合は作成されないこと" do
    click_on "作成"
    expect(page).to have_text("保存されませんでした")
  end

  it "新しいアーティストを追加のリンクをクリックすると新しいアーティストのページへ遷移すること", :js do
    click_link "アーティストを追加"
    expect(page).to have_current_path("/artists/new", ignore_query: true)
  end

  describe "ライブ記録の選択" do
    it "ライブ記録を選択すると、日付とアーティストのフィールドが更新される" do
      select live_record.name, from: "good_live_record_id"
      expect(page).to have_field("good_date", with: live_record.date)
      expect(page).to have_select("good_artist_id", selected: artist.name)
    end
  end

  describe "アーティストの選択" do
    it "アーティストを選択すると、メンバー選択フィールドが更新される" do
      select artist.name, from: "good_artist_id"
      expect(page).to have_select("good_member_id", options: ["-メンバーを選択-", member.name])
    end

    it "メンバーを追加でアーティスト編集ページに移行すること" do
      select artist.name, from: "good_artist_id"
      click_link "メンバーを追加"
      expect(page).to have_current_path(edit_artist_path(artist.id), ignore_query: true)
    end
  end

  describe "カテゴリーの選択" do
    it "「その他」を選択すると、カテゴリー追加フィールドが表示される" do
      select "その他", from: "category_selector"
      expect(page).to have_css("#new-categories", visible: true)
    end

    it "他のオプションを選択すると、カテゴリー追加フィールドが非表示になる" do
      select category.name , from: "category_selector"
      expect(page).to have_css("#new-categories", visible: false)
    end

    it "その他を選択して新しいカテゴリーが追加されること" do
      select "その他", from: "category_selector"
      fill_in "good_new_category_name", with: "ニューカテゴリー"
      click_button "作成"
      expect(page).to have_content("ニューカテゴリー")
    end
  end
end
