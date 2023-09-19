require 'rails_helper'

RSpec.describe "UserRegistration" do
  it "usernameが正しく登録されること" do
    visit new_user_registration_path
    fill_in "ユーザーネーム", with: "username"
    fill_in "メールアドレス", with: "test@example.com"
    fill_in "パスワード", with: "password"
    fill_in "確認用パスワード", with: "password"

    click_button "GO"
    expect(page).to have_current_path(root_path, ignore_query: true)
  end
end
