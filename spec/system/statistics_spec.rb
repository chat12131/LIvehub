require 'rails_helper'

RSpec.describe "Statistics" do
  describe "statistics page" do
    let(:user) { create(:user) }
    let!(:artist) { create(:artist, user: user) }
    let!(:live_record) { create(:live_record, user: user, artist: artist) }
    let!(:member) { create(:member, artist: artist) }
    let!(:category) { create(:category, user: user) }
    let!(:good) { create(:good, user: user, live_record: live_record, artist: artist, category: category, member: member, date: live_record.date) }

    before do
      login_as(user)
      visit statistics_path
    end

    it 'ライブ記録が表示されること' do
      expect(page).to have_content('ライブ記録の総数:')
      expect(page).to have_content('半年間のライブ数:')
      expect(page).to have_content('今月のライブ数:')
      expect(page).to have_content('ライブに参加したアーティスト数:')
    end

    it '支出情報が表示されること' do
      expect(page).to have_content('ライブとグッズの総支出 :')
      expect(page).to have_content('ライブの総支出 :')
      expect(page).to have_content('グッズの総支出 :')
      expect(page).to have_content('今月のグッズ購入数:')
    end

    it '月別ライブ数のグラフが表示されること' do
      expect(page).to have_selector('#monthlyLiveChart')
    end

    it '曜日別のライブ数のグラフが表示されること' do
      expect(page).to have_selector('#weeklyChart')
    end

    it 'ジャンル別の数のグラフが表示されること' do
      expect(page).to have_selector('#myChart')
    end

    it 'グッズカテゴリー別の支出のグラフが表示されること' do
      expect(page).to have_selector('#expenseChart')
    end
  end
end
