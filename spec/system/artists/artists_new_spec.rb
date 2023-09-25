require 'rails_helper'

RSpec.describe "Artists" do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit new_artist_path
  end

  context "正しく入力した時" do
    it "アーティストが作れること" do
      fill_in 'アーティスト名', with: 'Sample Artist'
      select 'ロック', from: 'ジャンル'
      click_button '保存'

      expect(page).to have_content('Sample Artist')
    end
  end

  context "何も入力しない時" do
    it "アーティストが作れないこと" do
      click_button '保存'
      expect(page).to have_button('保存')
    end
  end

  it "表示されていること" do
    expect(page).to have_field 'member-input'
    expect(page).to have_button '更に追加'
  end

  it "「更に追加」をクリックすると、メンバーが追加されること", :js do
    fill_in 'member-input', with: '新しいメンバー'
    click_button '更に追加'
    sleep 1
    expect(find_field('member-input').value).to eq ''
  end
end
