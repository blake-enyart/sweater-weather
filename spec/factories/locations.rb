FactoryBot.define do
  factory :location do
    city { Faker::Address.city}
    state { Faker::Address.state_abbr }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
