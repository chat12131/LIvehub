require "rails_helper"

RSpec.describe "Headers" do
  describe "GET /" do
    context "未ログインのユーザー" do
      before { get root_path }

      it "正しいレスポンスが返されること" do
        expect(response).to be_successful
      end

      it "「Livehub」のリンクが表示される" do
        expect(css_select("nav.navbar").text).to include("Livehub")
      end

      it "「ゲストログイン」が表示される" do
        expect(css_select("nav.navbar a.nav-link").text).to include("ゲストログイン")
      end

      it "「新規登録」が表示される" do
        expect(css_select("nav.navbar a.nav-link").text).to include("新規登録")
      end

      it "「ログイン」が表示される" do
        expect(css_select("nav.navbar a.nav-link").text).to include("ログイン")
      end

      it "「ライブ予定」は表示されない" do
        expect(css_select("nav.navbar a.nav-link").text).not_to  include("ライブ予定")
      end

      it "「ライブ記録」は表示されない" do
        expect(css_select("nav.navbar a.nav-link").text).not_to include("ライブ記録")
      end

      it "「グッズ記録」は表示されない" do
        expect(css_select("nav.navbar a.nav-link").text).not_to include("グッズ記録")
      end

      it "「統計」は表示されない" do
        expect(css_select("nav.navbar a.nav-link").text).not_to include("統計")
      end

      it "「マイページ」は表示されない" do
        expect(css_select("nav.navbar a.nav-link").text).not_to include("マイページ")
      end

      it "「登録アーティスト」は表示されない" do
        expect(css_select("nav.navbar a.nav-link").text).not_to include("登録アーティスト")
      end

      it "「ログアウト」は表示されない" do
        expect(css_select("nav.navbar a.nav-link").text).not_to include("ログアウト")
      end
    end

    context "ログイン済みのユーザー" do
      let(:user) { create(:user) }
      before do
        sign_in user
        get root_path
      end

      it "「Livehub」のリンクが表示される" do
        expect(css_select("nav.navbar").text).to include("Livehub")
      end

      it "「ライブ予定」が表示される" do
        expect(css_select("nav.navbar a.nav-link").text).to include("ライブ予定")
      end

      it "「ライブ記録」が表示される" do
        expect(css_select("nav.navbar a.nav-link").text).to include("ライブ記録")
      end

      it "「グッズ記録」が表示される" do
        expect(css_select("nav.navbar a.nav-link").text).to include("グッズ記録")
      end

      it "「統計」が表示される" do
        expect(css_select("nav.navbar a.nav-link").text).to include("統計")
      end

      it "「マイページ」が表示される" do
        expect(css_select("nav.navbar a.nav-link").text).to include("マイページ")
      end

      it "「登録アーティスト」が表示される" do
        expect(css_select("nav.navbar a.nav-link").text).to include("登録アーティスト")
      end

      it "「ログアウト」が表示される" do
        expect(css_select("nav.navbar a.nav-link").text).to include("ログアウト")
      end

      it "「ゲストログイン」は表示されない" do
        expect(css_select("nav.navbar a.nav-link").text).not_to include("ゲストログイン")
      end

      it "「新規登録」は表示されない" do
        expect(css_select("nav.navbar a.nav-link").text).not_to include("新規登録")
      end

      it "「ログイン」は表示されない" do
        expect(css_select("nav.navbar a.nav-link").text).not_to include("ログイン")
      end
    end
  end
end
