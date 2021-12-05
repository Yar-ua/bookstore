FactoryBot.define do
  factory :address do
    association :user, factory: :user
    
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_name }
    city { FFaker::Address.city }
    zip { rand(11111..99999) }
    country { 'Country' }
    phone { '+' + rand(11111111111..99999999999).round(0).to_s }

    trait :billing do
      address_type { :billing }
    end

    trait :shipping do
      address_type { :shipping }
    end
  end
end
