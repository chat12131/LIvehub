require 'rails_helper'

RSpec.describe "Artists#show" do
  let!(:user) { create(:user) }
  let!(:artist) { create(:artist, user:) }
  let!(:members) { create_list(:member, 3, artist: artist) }

  before do
    sign_in user
    get artist_path(artist)
  end

  it "正常にレスポンスが返されること" do
    expect(response).to be_successful
  end

  it "アーティストの名前が表示されていること" do
    expect(response.body).to include artist.name
  end

  it "アーティストのニックネームが表示されていること" do
    expect(response.body).to include artist.nickname
  end

  it "アーティストのジャンルが表示されていること" do
    expect(response.body).to include artist.genre
  end

  it "アーティストの結成日が表示されていること" do
    expect(response.body).to include artist.founding_date.to_s
  end

  it "アーティストの初めて見た日が表示されていること" do
    expect(response.body).to include artist.first_show_date.to_s
  end

  it "アーティストのメモが表示されていること" do
    expect(response.body).to include artist.memo
  end

  context "メンバーが存在する場合" do
    it "「メンバーを表示+」というテキストが存在すること" do
      expect(response.body).to include 'メンバーを表示+'
    end

    it "メンバーの名前が正しく表示されていること" do
      members.each do |member|
        expect(response.body).to include member.name
      end
    end
  end

  context "メンバーが存在しない場合" do
    before do
      members.each(&:destroy)
      get artist_path(artist)
    end

    it "「メンバーを表示+」というテキストが存在しないこと" do
      expect(response.body).not_to include 'メンバーを表示+'
    end
  end
end
