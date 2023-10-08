require 'rails_helper'

RSpec.describe "Statistics" do
  describe "statistics page" do
    let(:user) { create(:user) }

    before do
      login_as(user)
      visit statistics_path
    end

    it "displays the correct headings" do
      expect(page).to have_content("統計")
      expect(page).to have_content("ライブ記録")
      expect(page).to have_content("支出")
    end
  end
end
