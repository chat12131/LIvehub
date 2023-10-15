require "rails_helper"

RSpec.describe "UserRegistration" do
  let(:user) { create(:user) }
  before do
    visit new_user_session_path
  end

  it "usernameが正しく登録されること" do
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "GO"
    expect(page).to have_current_path(root_path)
  end

  it "usernameが登録されないこと" do
    fill_in "Email", with: "username"
    fill_in "Password", with: "test@example.com"

    click_button "GO"
    expect(page).to have_current_path(new_user_session_path)
  end
end
