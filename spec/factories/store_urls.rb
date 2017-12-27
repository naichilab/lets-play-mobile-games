FactoryBot.define do
  factory :store_url do
    sequence(:url) {|n| Faker::Internet.url('hogehoge.com') + "#{n}"}
    memo {['', Faker::Lorem.sentence].sample}

    game
    platform

    factory :invalid_store_url do
      url "   "
    end
  end
end
