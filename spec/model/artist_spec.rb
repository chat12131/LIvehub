require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe "バリデーション" do
    subject(:artist) { described_class.new(name: "Sample Artist", user: user) }

    let!(:user) { create(:user) }

    it "正しい属性を持つ場合は有効である" do
      expect(artist).to be_valid
    end

    it "名前がない場合は無効である" do
      artist.name = nil
      expect(artist).not_to be_valid
      expect(artist.errors.details[:name]).to include({ error: :blank })
    end

    it "名前が25文字より長い場合は無効である" do
      artist.name = "a" * 26
      expect(artist).not_to be_valid
      expect(artist.errors.details[:name]).to include({ error: :too_long, count: 25 })
    end

    it "ニックネームが10文字より長い場合は無効である" do
      artist.nickname = "a" * 11
      expect(artist).not_to be_valid
      expect(artist.errors.details[:nickname]).to include({ error: :too_long, count: 10 })
    end

    it "ユーザーが関連付けられていない場合は無効である" do
      artist.user = nil
      expect(artist).not_to be_valid
      expect(artist.errors.details[:user]).to include({ error: :blank })
    end

    context "ニックネームモードがオンのとき" do
      before { artist.nickname_mode = true }

      it "ニックネームが入力されていれば有効である" do
        artist.nickname = "Nickname"
        expect(artist).to be_valid
      end

      it "ニックネームが入力されていない場合は無効である" do
        artist.nickname = nil
        expect(artist).not_to be_valid
      end
    end

    context "dates validation" do
      it "結成日が未来の場合は無効である" do
        artist.founding_date = Date.tomorrow
        expect(artist).not_to be_valid
      end

      it "初めて見た日が結成日より前の場合は無効である" do
        artist.founding_date = Time.zone.today
        artist.first_show_date = Date.yesterday
        expect(artist).not_to be_valid
      end

      it "初めて見た日が未来の場合は無効である" do
        artist.first_show_date = Date.tomorrow
        expect(artist).not_to be_valid
      end
    end
  end
end
