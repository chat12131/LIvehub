require 'rails_helper'

RSpec.describe "Artists" do
  describe "GET /artists" do
    let!(:user) { create(:user) }
    let!(:artists) { create_list(:artist, 3, user:) }

    before do
      sign_in user
      get artists_path
    end

    it "正常なレスポンスが返ること" do
      expect(response).to have_http_status(:success)
    end

    it "アーティストの名前が表示されること" do
      artists.each do |artist|
        expect(response.body).to include(artist.name)
      end
    end

    it "'新規アーティスト作成'のボタンが表示されること" do
      expect(response.body).to include("新規アーティスト作成")
    end

    it "'お気に入り'のボタンが表示されること" do
      expect(response.body).to include("お気に入り")
    end

    it "各アーティストに'編集'ボタンが表示されること" do
      artists.each do |artist|
        expect(response.body).to include(edit_artist_path(artist))
      end
    end

    it "各アーティストに'削除'ボタンが表示されること" do
      artists.each do |artist|
        expect(response.body).to include(artist_path(artist))
      end
    end
  end
end
