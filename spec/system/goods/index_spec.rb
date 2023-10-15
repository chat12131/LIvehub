require 'rails_helper'

RSpec.describe "Goods" do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }
  let(:artist) { create(:artist, user: user) }
  let(:member) { create(:member, artist: artist) }
  let(:live_record) { create(:live_record, user: user) }
  let!(:good) { create(:good, user: user, category: category, artist: artist, member: member, live_record: live_record) }

  before do
    sign_in user
    visit goods_path
  end

  it "作成したグッズの名前が正しく表示されていること" do
    expect(page).to have_content(good.name)
  end

  it "作成したグッズの価格が正しく表示されていること" do
    expect(page).to have_content("値段: #{good.price}")
  end

  it "合計価格が正しく表示されていること" do
    expect(page).to have_content("合計: #{good.quantity * good.price}")
  end

  it "アーティスト名が正しく表示されていること" do
    expect(page).to have_content("アーティスト: #{good.artist.display_name}")
  end

  it "メンバー名が正しく表示されていること" do
    expect(page).to have_content("メンバー: #{good.member.name}")
  end

  it "購入したライブの名前が正しく表示されていること" do
    expect(page).to have_content("購入したライブ: #{good.live_record.name}")
  end

  it "購入日が正しく表示されていること" do
    expect(page).to have_content("購入日: #{good.date}")
  end

  it "グッズの編集ページに正しく遷移すること", :js do
    find(".fa-edit").click
    expect(page).to have_current_path edit_good_path(good)
  end

  it "グッズの削除時にポップアップが表示されること", :js do
    find(".fa-trash").click
    page.driver.browser.switch_to.alert.accept
    expect(page).not_to have_content(good.name)
  end
end
