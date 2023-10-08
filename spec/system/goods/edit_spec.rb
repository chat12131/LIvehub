require 'rails_helper'

RSpec.describe "Goods", :js do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }
  let(:good) { create(:good, user: user, category: category) }

  before do
    sign_in user
    visit edit_good_path(good)
  end

  it "既存のグッズの情報が表示されること" do
    expect(page).to have_field("商品名", with: good.name)
    expect(page).to have_field("個数", with: good.quantity.to_s)
    expect(page).to have_select('category_selector', selected: good.category.name)
  end

  it "グッズ記録が作成されること" do
    fill_in "商品名", with: "テスト商品"
    fill_in "個数", with: 10
    click_on "作成"

    expect(page).to have_current_path goods_path
    expect(page).to have_content("テスト商品")
    expect(page).to have_content("10")
  end

  it "何も入力しない場合は作成されないこと" do
    fill_in "個数", with: 0

    click_on "作成"

    expect(page).to have_text("保存されませんでした")
  end
end
