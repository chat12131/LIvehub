require 'rails_helper'

image_path = Rails.root.join('spec', 'fixtures', 'files', 'image.jpg')
uploaded_image = Rack::Test::UploadedFile.new(image_path, 'image/jpg')

FactoryBot.define do
  factory :user do
    username { "username" }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    avatar { uploaded_image }
  end
end
