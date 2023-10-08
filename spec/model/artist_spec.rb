require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe "バリデーション" do
    subject(:artist) { build(:artist) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(25) }
    it { should validate_length_of(:nickname).is_at_most(10) }
    it { should belong_to(:user) }
    it { should have_many(:members).dependent(:destroy) }
    it { should have_many(:live_records).dependent(:nullify) }
    it { should have_many(:live_schedules).dependent(:nullify) }

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

    context "日付のバリデーション" do
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

  describe "表示名関連のメソッド" do
    let(:artist) { build(:artist, name: "SampleName", nickname: "SampleNickname") }

    context "ニックネームモードがオンでニックネームが設定されている場合" do
      before { artist.nickname_mode = true }

      it "ニックネームを返す" do
        expect(artist.display_name).to eq "SampleNickname"
      end
    end

    context "ニックネームモードがオフ" do
      before { artist.nickname_mode = false }

      it "ニックネームを返す" do
        expect(artist.non_display_name).to eq "SampleNickname"
      end
    end

    context "non_display_nameが存在する場合" do
      it "display_nameとnon_display_nameの組み合わせを返す" do
        expect(artist.combined_name).to eq "SampleName(SampleNickname)"
      end
    end
  end
end
