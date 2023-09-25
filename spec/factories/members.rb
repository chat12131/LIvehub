FactoryBot.define do
  factory :member do
    name { Faker::Name.unique.name }
    artist
  end
end
