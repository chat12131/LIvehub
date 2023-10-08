require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'associations' do
    it { should belong_to(:artist) }
    it { should have_many(:goods).dependent(:nullify) }
  end
end
