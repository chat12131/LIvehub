require 'rails_helper'

RSpec.describe "Artists" do
  describe "アーティスト編集" do
    let(:user) { create(:user) }
    let(:artist) { create(:artist, user:) }

    before do
      sign_in user
      visit edit_artist_path(artist)
    end

    context "有効な情報を入力したとき" do
      it "アーティスト情報が正しく更新されること" do
        fill_in "アーティスト名", with: "更新されたアーティスト名"
        fill_in "ニックネーム", with: "新しいニックネーム"
        select "Jpop", from: "ジャンル"
        click_button "更新"
        expect(page).to have_content("更新されたアーティスト名")
        expect(page).to have_content("新しいニックネーム")
      end
    end

    context "無効な情報を入力したとき" do
      it "エラーメッセージが表示されること" do
        fill_in "アーティスト名", with: ""
        click_button "更新"
        expect(page).to have_button("更新")
      end
    end
  end
end
