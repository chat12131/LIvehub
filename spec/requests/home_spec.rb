# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home' do
  describe 'GET /' do
    it 'アクセスが正常に返されること' do
      get root_path
      expect(response).to be_successful
    end
  end
end
