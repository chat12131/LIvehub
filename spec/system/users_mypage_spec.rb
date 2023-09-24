require 'rails_helper'

RSpec.describe "MyPage" do
  let(:user) { create(:user) }

  context "ログイン前の場合" do
    it "マイページでログインリダイレクトされること" do
      visit mypage_path
      expect(page).to have_current_path(new_user_session_path, ignore_query: true)
    end
  end

  context "ログイン中の場合" do
    before do
      login_as(user)
      visit mypage_path
    end

    it "usernameが正しく表示されること" do
      expect(page).to have_content(user.username)
    end

    it "emailが正しく表示されること" do
      expect(page).to have_content(user.email)
    end

    it 'アバターが表示されること' do
      expect(page).to have_css('img.user-avatar')
    end
  end
end
