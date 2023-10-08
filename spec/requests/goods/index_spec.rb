require 'rails_helper'

RSpec.describe "Goods", type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }
  let(:artist) { create(:artist, user: user) }
  let(:member) { create(:member, artist: artist) }
  let(:live_record) { create(:live_record, user: user) }
  let!(:good) { create(:good, user: user, category: category, artist: artist, member: member, live_record: live_record) }

  before do
    sign_in user
    get goods_path
  end

  it 'レスポンスが正しく返されること' do
    expect(response).to be_successful
  end

  it "作成したグッズの名前が正しく表示されていること" do
    expect(response.body).to include(good.name)
  end

  it "作成したグッズの価格が正しく表示されていること" do
    expect(response.body).to include("値段: #{good.price}")
  end

  it "合計価格が正しく表示されていること" do
    expect(response.body).to include("合計: #{good.quantity * good.price}")
  end

  it "アーティスト名が正しく表示されていること" do
    expect(response.body).to include("アーティスト: #{good.artist.display_name}")
  end

  it "メンバー名が正しく表示されていること" do
    expect(response.body).to include("メンバー: #{good.member.name}")
  end

  it "購入したライブの名前が正しく表示されていること" do
    expect(response.body).to include("購入したライブ: #{good.live_record.name}")
  end

  it "購入日が正しく表示されていること" do
    expect(response.body).to include("購入日: #{good.date}")
  end
end
