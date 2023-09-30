FactoryBot.define do
  factory :venue do
    name { "Sample" }
    google_place_id { "ChIJN1t_tDeuEmsRUsoyG83frY4" }
    user { FactoryBot.create(:user) }
    latitude { 35.6895 }
    longitude { 139.6917 }
    area { "Tokyo" }
  end
end
