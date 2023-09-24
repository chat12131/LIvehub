require 'rails_helper'

RSpec.describe "Artists#favorites" do
  let!(:user) { create(:user) }
  let!(:favorite_artist) { create(:artist, user:, favorited: true) }
  let!(:non_favorite_artist) { create(:artist, :non_favorite_artist_name_only, user:) }

  before do
    sign_in user
    get favorites_artists_path
  end

  describe "GET /artists/favorites" do
    it "is successful" do
      expect(response).to be_successful
    end

    it "お気に入りのアーティストが表示されること" do
      expect(response.body).to include favorite_artist.name
    end

    it "非お気に入りのアーティストが表示されないこと" do
      expect(response.body).not_to include non_favorite_artist.name
    end
  end
end
