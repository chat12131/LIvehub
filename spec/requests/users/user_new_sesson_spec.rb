require "rails_helper"

RSpec.describe "Sessions" do
  let(:user) { create(:user) }

  before do
    get new_user_session_path
  end

  it "レスポンスが正しく返されること" do
    expect(response).to be_successful
  end

  it "有効な情報を送信するとログインし、リダイレクトされること" do
    post user_session_path, params: { user: { email: user.email, password: user.password } }
    expect(response).to redirect_to(root_path)
  end

  it "無効な情報を送信するとログインに失敗し、ログインページを再表示すること" do
    post user_session_path, params: { user: { email: "invalid@example.com", password: "wrong_password" } }
    expect(response).to render_template("new")
  end
end
