require 'rails_helper'

RSpec.describe "Artists#show" do
  let!(:user) { create(:user) }
  let!(:artist) { create(:artist, user:) }

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
end
