require 'rails_helper'

RSpec.describe 'Header features' do
  context 'ログイン中の場合' do
    let(:user) { create(:user) }

    before do
      login_as(user, scope: :user)
      visit root_path
    end

    it 'ライブ予定が正しく機能すること' do
      first('a', text: 'ライブ予定').click
      expect(page).to have_current_path(live_schedules_path)
    end

    it 'ライブ記録が正しく機能すること' do
      first('a', text: 'ライブ記録').click
      expect(page).to have_current_path('/')
    end

    it 'グッズ記録が正しく機能すること' do
      first('a', text: 'グッズ記録').click
      expect(page).to have_current_path('/')
    end

    it '統計が正しく機能すること' do
      first('a', text: '統計').click
      expect(page).to have_current_path('/')
    end

    it 'マイページのリンクが正しいこと' do
      click_on user.username
      click_link 'マイページ'
      expect(page).to have_current_path(mypage_path)
    end

    it '登録アーティストのリンクが正しいこと' do
      click_on user.username
      click_link '登録アーティスト'
      expect(page).to have_current_path(artists_path)
    end

    it 'ログアウトが機能すること' do
      click_on user.username
      click_link 'ログアウト'
      expect(page).to have_current_path(root_path)
    end
  end

  context 'ログイン前の場合' do
    before do
      visit root_path
    end

    it '新規登録が正しいこと' do
      click_link '新規登録'
      expect(page).to have_current_path(new_user_registration_path)
    end

    it 'ログインが正しいこと' do
      click_link 'ログイン'
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
