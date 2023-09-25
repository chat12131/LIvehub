require 'rails_helper'

RSpec.describe "Artists" do
  describe "POST /artists" do
    let(:user) { create(:user) }
    let(:valid_attributes) do
      { name: 'Sample Artist', genre: 'ロック' }
    end

    before do
      sign_in user
      get new_artist_path
    end

    it 'レスポンスが正しく返されること' do
      expect(response).to be_successful
    end

    it "アーティストが作成できること" do
      expect do
        post artists_path, params: { artist: valid_attributes }
      end.to change(Artist, :count).by(1)
    end

    it "作成後のリダイレクトが正しいこと" do
      post artists_path, params: { artist: valid_attributes }
      expect(response).to redirect_to(artists_path)
    end

    it "メンバーフィールドが含まれること" do
      expect(response.body).to include 'メンバーの名前'
    end

    it "「更に追加」ボタンが存在すること" do
      expect(response.body).to include '更に追加'
    end
  end
end
