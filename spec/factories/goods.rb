FactoryBot.define do
  factory :good do
    name { "Sample Good" }
    price { 1000 }
    quantity { 1 }
    date { Date.today }
    user
    category
    artist
  end
end
