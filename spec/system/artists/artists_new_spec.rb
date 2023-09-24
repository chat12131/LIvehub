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
end
