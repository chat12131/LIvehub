require 'rails_helper'

RSpec.describe "MyPage", type: :system do
  let(:user) { create(:user) }

  context "ログイン前の場合" do
    it "マイページでログインリダイレクトされること" do
      visit mypage_path
      expect(current_path).to eq(new_user_session_path)
    end
  end

  context "ログイン中の場合" do
    before do
      login_as(user)
      visit mypage_path
    end

    it "usernameが正しく表示されること" do
      expect(page).to have_content(user.email)
    end

    it "emailが正しく表示されること" do
      expect(page).to have_content(user.email)
    end

    it "編集アイコンで編集ページにアクセスできること" do
      find("i.fas.fa-edit").click
      expect(current_path).to eq(edit_user_registration_path)
    end
  end
end
