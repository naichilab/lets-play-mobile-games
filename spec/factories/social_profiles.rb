FactoryBot.define do
  factory :social_profile do
    user
    provider "Twitter"
    sequence(:uid) { |n| Faker::Internet.slug.gsub(/\./,'-') + "#{n}" }
    name { Faker::Book.title }
    nickname { Faker::Book.title }
    email {Faker::Internet.email }
    url {Faker::Internet.url}
    image_url 'http://localhost:3000/assets/img/main/img11.jpg'
    description {Faker::Lorem.paragraph}
    other "MyText"
    credentials "MyText"
    raw_info "MyText"
  end
end
