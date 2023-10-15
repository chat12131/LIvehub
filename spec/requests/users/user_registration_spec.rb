require "rails_helper"

RSpec.describe "User Registrations" do
  describe "POST /users" do
    let(:valid_attributes) { attributes_for(:user) }
    let(:invalid_attributes) { attributes_for(:user, username: "") }


    it "正しいレスポンスが返されること" do
      get new_user_registration_path
      expect(response).to be_successful
    end

    it "ユーザーが正常に登録されること" do
      post user_registration_path, params: { user: valid_attributes }
      expect(response).to redirect_to(root_path)
      expect(User.last.username).to eq("username")
    end

    it "ユーザーが登録されないこと" do
      post user_registration_path, params: { user: invalid_attributes }
      expect(User.count).to eq(0)
    end
  end
end
