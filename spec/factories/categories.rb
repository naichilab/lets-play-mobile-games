FactoryBot.define do
  factory :category do
    sequence(:name) {|n| "カテゴリー#{n}" }

    factory :invalid_category do
      name "   "
    end

  end
end