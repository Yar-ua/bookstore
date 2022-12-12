FactoryBot.define do
  factory :address do
    association :addressable, factory: :user

    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_name }
    city { FFaker::Address.city }
    zip { rand(11_111..99_999) }
    country { 'Country' }
    phone { "+#{rand(11_111_111_111..99_999_999_999).round(0)}" }

    trait :billing do
      type { 'BillingAddress' }
    end

    trait :shipping do
      type { 'ShippingAddress' }
    end
  end
end
