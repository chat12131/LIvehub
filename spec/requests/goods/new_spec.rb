require 'rails_helper'

RSpec.describe "Goods" do
  let(:user) { create(:user) }
  let!(:category) { create(:category, user: user) }

  before do
    sign_in user
    get new_good_path
  end

  describe "GET /new" do
    it 'レスポンスが正しく返されること' do
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    let(:valid_attributes) { { name: "テスト商品", category_id: category.id, quantity: 1 } }

    context "有効なパラメーターの場合" do
      it "新しい商品を作成する", :js do
        expect do
          post goods_path, params: { good: valid_attributes }
        end.to change(Good, :count).by(1)
        expect(response).to redirect_to(goods_path)
      end
    end
  end
end
