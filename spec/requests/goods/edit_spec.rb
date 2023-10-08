require 'rails_helper'

RSpec.describe "Goods" do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }
  let!(:good) { create(:good, user: user, category: category) }

  before do
    sign_in user
  end

  describe "GET /edit" do
    it "既存の商品情報を編集するページが表示されること" do
      get edit_good_path(good)
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context "有効なパラメーターの場合" do
      let(:valid_attributes) { { name: "更新された商品名", category_id: category.id, quantity: 2 } }

      it "商品情報が更新されること" do
        patch good_path(good), params: { good: valid_attributes }
        expect(good.reload.name).to eq("更新された商品名")
        expect(response).to redirect_to(goods_path)
      end
    end

    context "無効なパラメーターの場合" do
      let(:invalid_attributes) { { name: "", category_id: category.id, quantity: 0 } }

      it "商品情報が更新されないこと" do
        patch good_path(good), params: { good: invalid_attributes }
        expect(good.reload.name).not_to eq("")
        expect(response).to render_template(:edit)
      end
    end
  end
end
