require 'rails_helper'

RSpec.describe "Goods", :js do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }

  before do
    sign_in user
    visit new_good_path
  end

  it "グッズ記録が作成されること" do
    fill_in "商品名", with: "テスト商品"
    fill_in "個数", with: 10
    find_by_id('category_selector').set(category.name)
    click_on "作成"

    expect(page).to have_current_path goods_path
  end

  it "何も入力しない場合は作成されないこと" do
    click_on "作成"

    expect(page).to have_text("保存されませんでした")
  end
end
