require "rails_helper"

RSpec.describe "homepage" do
  let(:user) { create(:user) }

  before do
    visit root_path
  end

  it "表示内容にLivehubが含まれること" do
    within(".home") do
      expect(page).to have_content "Livehub"
    end
  end

  context "ログイン前の場合" do
    it "新規登録のリンクが正しいこと" do
      within(".home") do
        click_link "新規登録"
      end
      expect(page).to have_current_path(new_user_registration_path)
    end

    it "新規登録のリンクが正しいこと" do
      within(".home") do
        click_link "ログイン"
      end
      expect(page).to have_current_path(new_user_session_path)
    end

    it "新規登録のリンクが正しいこと" do
      within(".home") do
        click_link "ゲスト用"
      end
      expect(page).to have_content("統計")
    end
  end

  context "ログイン中の場合" do
    before do
      login_as(user)
      visit root_path
    end

    it "ライブ予定が正しく機能すること" do
      within(".home") do
        click_link "ライブ予定"
      end
      expect(page).to have_current_path(live_schedules_path)
    end

    it "ライブ予定が正しく機能すること" do
      within(".home") do
        click_link "ライブ記録"
      end
      expect(page).to have_current_path(live_records_path)
    end

    it "ライブ予定が正しく機能すること" do
      within(".home") do
        click_link "グッズ記録"
      end
      expect(page).to have_current_path(goods_path)
    end

    it "ライブ予定が正しく機能すること" do
      within(".home") do
        click_link "統計"
      end
      expect(page).to have_current_path(statistics_path)
    end
  end
end
