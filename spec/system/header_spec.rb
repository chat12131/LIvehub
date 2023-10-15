require "rails_helper"

RSpec.describe "Header" do
  context "ログイン中の場合" do
    let(:user) { create(:user) }

    before do
      login_as(user, scope: :user)
      visit root_path
    end

    it "ライブ予定が正しく機能すること" do
      within("nav.navbar") do
        first(:link, text: "ライブ予定").click
      end
      expect(page).to have_current_path(live_schedules_path)
    end

    it "ライブ記録が正しく機能すること" do
      within("nav.navbar") do
        first(:link, text: "ライブ記録").click
      end
      expect(page).to have_current_path(live_records_path)
    end

    it "グッズ記録が正しく機能すること" do
      within("nav.navbar") do
        first(:link, text: "グッズ記録").click
      end
      expect(page).to have_current_path(goods_path)
    end

    it "統計が正しく機能すること" do
      within("nav.navbar") do
        first(:link, text: "統計").click
      end
      expect(page).to have_current_path(statistics_path)
    end

    it "マイページのリンクが正しいこと" do
      click_on user.username
      first(:link, "マイページ").click
      expect(page).to have_current_path(mypage_path)
    end

    it "登録アーティストのリンクが正しいこと" do
      click_on user.username
      first(:link, "登録アーティスト").click
      expect(page).to have_current_path(artists_path)
    end

    it "ログアウトが機能すること" do
      click_on user.username
      first(:link, "ログアウト").click
      expect(page).to have_current_path(root_path)
    end

    it "livehubでtopページに移動すること" do
      visit mypage_path
      click_link "Livehub"
      expect(page).to have_current_path(root_path)
    end

  end

  context "ログイン前の場合" do
    before do
      visit root_path
    end

    it "新規登録が正しいこと" do
      within("nav.navbar") do
        first(:link, "新規登録").click
      end
      expect(page).to have_current_path(new_user_registration_path)
    end

    it "ログインが正しいこと", :js do
      find(".navbar-toggler").click
      expect(page).to have_selector("#navbarNavDropdown.show")
      within("#navbarNavDropdown") do
        click_link "ログイン"
      end
      expect(page).to have_current_path(new_user_session_path)
    end

    it "ゲストログインが正しいこと" do
      first(:link, "ゲストログイン").click
      expect(page).to have_content("統計")
    end
  end
end
