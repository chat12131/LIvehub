require "rails_helper"

RSpec.describe Venue, type: :model do
  describe "associations" do
    it { should have_many(:live_schedules).dependent(:nullify) }
    it { should have_many(:live_records).dependent(:nullify) }
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
