FactoryBot.define do
  factory :live_schedule do
    name { "Sample Live Event" }
    artist { FactoryBot.create(:artist) }
    date { Time.zone.today + 3.days }
    open_time { 1.hours.from_now }
    start_time { 2.hours.from_now }
    venue { FactoryBot.create(:venue) }
    ticket_status { 1 }
    ticket_price { 3000 }
    drink_price { 500 }
    memo { "Some additional notes about the event." }
    user
  end
end
