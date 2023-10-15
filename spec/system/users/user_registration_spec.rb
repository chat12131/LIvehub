require 'rails_helper'

RSpec.describe "UserRegistration" do
  before do
    visit new_user_registration_path
  end

  it "usernameが正しく登録されること" do
    fill_in "ユーザーネーム", with: "username"
    fill_in "メールアドレス", with: "test@example.com"
    fill_in "パスワード", with: "password"
    fill_in "確認用パスワード", with: "password"

    click_button "GO"
    expect(page).to have_current_path(root_path)
  end

  it "usernameが登録されないこと" do
    visit new_user_registration_path
    fill_in "ユーザーネーム", with: "username"
    fill_in "メールアドレス", with: "test@example.com"

    click_button "GO"
    expect(page).to have_content("保存されませんでした")
  end
end
