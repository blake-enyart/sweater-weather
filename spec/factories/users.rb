FactoryBot.define do
  factory :user do
    sequence(:email) { Faker::Internet.email }
    sequence(:password) { Faker::Internet.password(8) }
    api_key { Digest::SHA1.hexdigest(email) }
  end
end
