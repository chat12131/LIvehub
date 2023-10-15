require "rails_helper"

RSpec.describe "Homepages", type: :request do
  describe "GET /" do
    let(:user) { create(:user) }

    before { get root_path }

    it "正しいレスポンスが返されること" do
      expect(response).to be_successful
    end

    it "livehubが表示されること" do
      expect(css_select(".home").text).to include("Livehub")
    end

    context "ログイン前の場合" do
      it "新規登録が表示されること" do
        expect(css_select(".home").text).to include("新規登録")
      end

      it "ログインが表示されること" do
        expect(css_select(".home").text).to include("ログイン")
      end

      it "ゲスト用が表示されること" do
        expect(css_select(".home").text).to include("ゲスト用")
      end

      it "ライブ予定が表示されないこと" do
        expect(css_select(".home").text).not_to include("ライブ予定")
      end

      it "グッズ記録が表示されないこと" do
        expect(css_select(".home").text).not_to include("グッズ記録")
      end

      it "ライブ記録が表示されないこと" do
        expect(css_select(".home").text).not_to include("ライブ記録")
      end

      it "統計が表示されないこと" do
        expect(css_select(".home").text).not_to include("統計")
      end

    end

    context "ログイン後の場合" do
      before do
        sign_in user
        get root_path
      end

      it "ライブ予定が表示されること" do
        expect(css_select(".home").text).to include("ライブ予定")
      end

      it "グッズ記録が表示されること" do
        expect(css_select(".home").text).to include("グッズ記録")
      end

      it "ライブ記録が表示されること" do
        expect(css_select(".home").text).to include("ライブ記録")
      end

      it "統計が表示されること" do
        expect(css_select(".home").text).to include("統計")
      end

      it "新規登録が表示されないこと" do
        expect(css_select(".home").text).not_to include("新規登録")
      end

      it "ログインが表示されないこと" do
        expect(css_select(".home").text).not_to include("ログイン")
      end

      it "ゲスト用が表示されないこと" do
        expect(css_select(".home").text).not_to include("ゲスト用")
      end
    end
  end
end
