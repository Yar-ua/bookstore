FactoryBot.define do
  factory :user do
    email { FFaker::Internet.unique.email }
    password { FFaker::Internet.unique.password }
    password_confirmation { password }
    confirmed_at { Time.now }
    
    trait :with_address do
      after(:build) do |user|
        user.billing_address = build(:billing_address)
        user.shipping_address = build(:shipping_address)
      end
    end
  end
end
