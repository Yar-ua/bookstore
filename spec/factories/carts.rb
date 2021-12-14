FactoryBot.define do
  factory :cart do
    trait :with_user do
      user
    end

    trait :with_coupon do
      coupon
    end

    transient do
      line_items_size { rand(1..10) }
    end

    trait :filled do
      after(:build) do |cart, evaluator|
        cart.line_items = build_list(:line_item, evaluator.line_items_size)
      end
    end
  end
end
