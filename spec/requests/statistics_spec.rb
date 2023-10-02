require 'rails_helper'

RSpec.describe "Statistics", type: :request do
  describe "GET /statistics" do
    let(:user) { create(:user) }

    before do
      login_as(user)
      get statistics_path
    end

    it 'アクセスが正常に返されること' do
      expect(response).to be_successful
    end
  end
end
