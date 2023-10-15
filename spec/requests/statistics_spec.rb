require 'rails_helper'

RSpec.describe "Statistics" do
  describe "GET /statistics" do
    let(:user) { create(:user) }
    let!(:artist) { create(:artist, user: user) }
    let!(:live_record) { create(:live_record, user: user, artist: artist) }
    let!(:member) { create(:member, artist: artist) }
    let!(:category) { create(:category, user: user) }
    let!(:good) { create(:good, user: user, live_record: live_record, artist: artist, category: category, member: member, date: live_record.date) }

    before do
      login_as(user)
      get statistics_path
    end

    it 'レスポンスが正しく返されること' do
      expect(response).to be_successful
    end

    it 'ライブ記録の総数が正しく表示されること' do
      expect(response.body).to match /ライブ記録の総数:/
    end

    it '半年間のライブ数が正しく表示されること' do
      expect(response.body).to match /半年間のライブ数:/
    end

    it '今月のライブ数が正しく表示されること' do
      expect(response.body).to match /今月のライブ数:/
    end

    it 'ライブに参加したアーティスト数が正しく表示されること' do
      expect(response.body).to match /ライブに参加したアーティスト数:/
    end

    it 'ライブとグッズの総支出が正しく表示されること' do
      expect(response.body).to match /ライブとグッズの総支出 :/
    end

    it 'ライブの総支出が正しく表示されること' do
      expect(response.body).to match /ライブの総支出 :/
    end

    it 'グッズの総支出が正しく表示されること' do
      expect(response.body).to match /グッズの総支出 :/
    end

    it '今月のグッズ購入数が正しく表示されること' do
      expect(response.body).to match /今月のグッズ購入数:/
    end

    it 'グッズランキングが正しく表示されること' do
      expect(response.body).to match /グッズランキング/
    end

    it '会場ランキングが正しく表示されること' do
      expect(response.body).to match /会場ランキング/
    end

    it '月別ライブ数が正しく表示されること' do
      expect(response.body).to match /月別ライブ数/
    end

    it '曜日別のライブ数が正しく表示されること' do
      expect(response.body).to match /曜日別のライブ数/
    end

    it 'ジャンル別の数が正しく表示されること' do
      expect(response.body).to match /ジャンル別の数/
    end

    it 'グッズカテゴリー別の支出が正しく表示されること' do
      expect(response.body).to match /グッズカテゴリー別の支出/
    end

  end
end
