require "rails_helper"

RSpec.describe "UserEdits" do
  describe "username update" do
    let(:user) { create(:user) }
    let(:new_email) { Faker::Internet.email }

    before do
      sign_in user
      visit edit_user_registration_path
    end

    it "ユーザーネームとメールアドレスが表示されること" do
      expect(page).to have_field("ユーザーネーム", with: user.username)
      expect(page).to have_field("メールアドレス", with: user.email)
    end

    context "usernameのみ変更する場合" do
      it "usernameが変更できること" do
        fill_in "ユーザーネーム", with: "new"
        click_button "変更"
        expect(page).to have_current_path(root_path)
        expect(user.reload.username).to eq("new")
      end
    end

    context "username以外も変更する場合" do
      it "usernameとemailを変更できないこと" do
        fill_in "ユーザーネーム", with: "new"
        fill_in "メールアドレス", with: new_email
        click_button "変更"
        expect(user.reload.email).not_to eq(user.username)
        expect(user.reload.email).not_to eq(new_email)
      end

      it "usernameとemailを変更できること" do
        fill_in "ユーザーネーム", with: "new"
        fill_in "メールアドレス", with: new_email
        fill_in "現在のパスワード", with: "password"
        click_button "変更"
        expect(page).to have_current_path(root_path)
        expect(user.reload.username).to eq("new")
        expect(user.reload.email).to eq(new_email)
      end
    end
  end
end
