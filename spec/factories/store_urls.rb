FactoryBot.define do
  factory :store_url do
    url Faker::Internet.url('hogehoge.com')
    memo {['', Faker::Lorem.sentence].sample(1).first}

    game
    platform

    factory :invalid_store_url do
      url "   "
    end
  end
end
