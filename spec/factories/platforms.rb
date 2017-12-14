FactoryBot.define do
  factory :platform do
    sequence(:code) {|n| "platform#{n}"}
    sequence(:name) {|n| "プラットフォーム#{n}"}

    factory :invalid_platform do
      code "  "
    end
    
  end
end
