FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.user_name }
    password { 'hogehoge' }

    trait :with_social_profile do
      after(:create) do |user|
        user.social_profiles << create(:social_profile, user: user)
      end
    end

    factory :admin_user do
      admin true
    end

    factory :invalid_user do
      username '   '
    end

  end
end