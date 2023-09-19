require 'rails_helper'

RSpec.describe "MyPage" do
  describe "GET /mypage" do
    let(:user) { create(:user) }

    before do
      sign_in user
      get mypage_path
    end

    it 'レスポンスが正しく返されること' do
      expect(response).to be_successful
    end

    it 'usernameが表示されること' do
      expect(response.body).to include(user.username)
    end

    it 'emailが表示されること' do
      expect(response.body).to include(user.email)
    end
  end
end
