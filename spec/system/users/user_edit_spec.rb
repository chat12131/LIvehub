require 'rails_helper'

RSpec.describe "UserEdits", type: :system do
  describe "username update" do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit edit_user_registration_path
    new_email = Faker::Internet.email
  end

  context "usernameのみ変更する場合" do
    it "usernameが変更できること" do
      fill_in "ユーザーネーム", with: "new_username"
      click_button "変更"
      expect(current_path).to eq(root_path)
      expect(user.reload.username).to eq(new_username)
    end
  end

  context "username以外も変更する場合" do
    it "usernameとemailを変更できないこと" do
      fill_in "ユーザーネーム", with: "new_username"
      fill_in "メールアドレス", with: Faker::Internet.email
      click_button "変更"
      expect(current_path).to eq(edit_user_registration_path)
      expect(user.reload.email).not_to eq(new_email)
    end

    it 'usernameとemailを変更できること' do
      fill_in "ユーザーネーム", with: "new_username"
      fill_in "メールアドレス", with: Faker::Internet.email
      fill_in "現在のパスワード", with: "password"
      click_button "変更"
      expect(current_path).to eq(root_path)
      expect(user.reload.username).to eq(new_username)
      expect(user.reload.email).to eq(new_email)
    end
  end
end
