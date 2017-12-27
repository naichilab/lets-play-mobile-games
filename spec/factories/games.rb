FactoryBot.define do
  factory :game do
    title {Faker::App.name}
    specific_conditions {[nil, Faker::Lorem.sentence].sample}
    guideline {[nil, Faker::Lorem.sentence].sample}
    android_url {['', Faker::Internet.url('example.com')].sample}
    ios_url {['', Faker::Internet.url('example.com')].sample}

    user
    category

    factory :invalid_game do
      title "   "
    end
  end
end