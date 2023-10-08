FactoryBot.define do
  factory :good do
    name { "Sample Good" }
    price { 1000 }
    quantity { 1 }
    date { Time.zone.today }
    user
    category
    artist
  end
end
