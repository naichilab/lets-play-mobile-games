FactoryBot.define do
  factory :game do
    title {Faker::App.name}
    specific_conditions {Faker::Lorem.sentence}
    android_url {['', Faker::Internet.url('example.com')].sample(1).first}
    ios_url {['', Faker::Internet.url('example.com')].sample(1).first}

    user
    category
  end
end