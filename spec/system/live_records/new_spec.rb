require "rails_helper"

RSpec.describe "LiveRecords" do
  describe "新規ライブ記録作成ページ" do
    let(:user) { create(:user) }

    before do
      sign_in user
      visit new_live_record_path
    end

    it "正常な情報でライブ記録を作成すると、記録が保存されること", :js do
      execute_script("document.querySelector('#live_record_date').value = '2023-10-01'")
      find_by_id("venue-name-display").set("新しい会場名")
      execute_script("window.scrollBy(0,10000)")
      click_button "登録"

      expect(page).to have_current_path live_records_path
    end

    it "不正な情報でライブ記録が作成されないこと", :js do
      execute_script("document.querySelector('#live_record_date').value = '2023-10-01'")
      execute_script("window.scrollBy(0,10000)")
      click_button "登録"

      expect(page).to have_content("保存されませんでした")
    end

    it "新しいアーティストを追加のリンクをクリックすると新しいアーティストのページへ遷移すること", :js do
      click_link "新しいアーティストを追加"
      expect(page).to have_current_path("/artists/new", ignore_query: true)
    end
  end
end
