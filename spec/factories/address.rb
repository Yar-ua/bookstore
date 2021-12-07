FactoryBot.define do
  factory :address do
    association :user, factory: :user

    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_name }
    city { FFaker::Address.city }
    zip { rand(11_111..99_999) }
    country { 'Country' }
    phone { "+#{rand(11_111_111_111..99_999_999_999).round(0)}" }

    trait :billing do
      address_type { :billing }
    end

    trait :shipping do
      address_type { :shipping }
    end
  end
end
