FactoryBot.define do
  factory :live_record do
    name { 'テスト' }
    date { Time.zone.today - 1.day }
    ticket_price { 3000 }
    drink_price { 500 }
    memo { 'メモの内容' }
    start_time { 7.hours.from_now }
    venue { FactoryBot.create(:venue) }
    user
    artist { FactoryBot.create(:artist) }
  end
end
