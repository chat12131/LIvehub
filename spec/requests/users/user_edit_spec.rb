require 'rails_helper'

RSpec.describe 'ユーザー編集' do
  describe 'PUT /users' do
    let(:user) { create(:user) }
    let(:new_username) { 'ユーザー' }
    let(:new_email) { Faker::Internet.email }

    before do
      sign_in user
      get edit_user_registration_path
    end

    it '現在のパスワードなしではユーザーネームとメールアドレスが更新されない' do
      put user_registration_path, params: { user: { username: new_username, email: new_email } }
      expect(user.reload.username).not_to eq(new_username)
      expect(user.reload.email).not_to eq(new_email)
    end

    it '現在のパスワードありでユーザーネームとメールアドレスが更新される' do
      put user_registration_path, params: { user: { username: new_username, email: new_email, current_password: user.password } }
      expect(response).to redirect_to(root_path)
      expect(user.reload.username).to eq(new_username)
      expect(user.reload.email).to eq(new_email)
    end
  end
end
