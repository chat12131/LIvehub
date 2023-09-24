FactoryBot.define do
  factory :artist do
    name { "Sample Artist" }
    nickname { "Nickname" }
    genre { "ロック" }
    founding_date { "2020-01-01" }
    first_show_date { "2020-02-01" }
    favorited { false }
    nickname_mode { false }
    memo { "Sample Memo" }
    user
    trait :non_favorite_artist_name_only do
      name { "NonFavoriteArtistName" }
    end
  end
end
