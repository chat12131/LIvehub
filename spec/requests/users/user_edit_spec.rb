require 'rails_helper'

RSpec.describe 'ユーザー編集', type: :request do
  describe 'PUT /users' do
    let(:user) { create(:user) }
    let(:新しいユーザーネーム) { '新しいユーザーネーム' }
    let(:新しいメールアドレス) { Faker::Internet.email }

    before do
      sign_in user
      get edit_user_registration_path
    end

    context 'ユーザーネームだけを更新する場合' do
      it 'ユーザーネームが更新される' do
        put user_registration_path, params: { user: { username: 新しいユーザーネーム } }
        expect(response).to redirect_to(root_path)
        expect(user.reload.username).to eq(新しいユーザーネーム)
      end
    end

    context 'ユーザーネームとメールアドレスを更新する場合' do
      it '現在のパスワードなしではユーザーネームとメールアドレスが更新されない' do
        put user_registration_path, params: { user: { username: 新しいユーザーネーム, email: 新しいメールアドレス } }
        expect(response).to redirect_to(edit_user_registration_path)
        expect(user.reload.username).not_to eq(新しいユーザーネーム)
        expect(user.reload.email).not_to eq(新しいメールアドレス)
      end

      it '現在のパスワードありでユーザーネームとメールアドレスが更新される' do
        put user_registration_path, params: { user: { username: 新しいユーザーネーム, email: 新しいメールアドレス, current_password: user.password } }
        expect(response).to redirect_to(root_path)
        expect(user.reload.username).to eq(新しいユーザーネーム)
        expect(user.reload.email).to eq(新しいメールアドレス)
      end
    end
  end
end
