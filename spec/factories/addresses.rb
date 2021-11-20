FactoryBot.define do
  factory :address do
    association :user, factory: :user
    
    first_name { 'FisttName' }
    last_name { 'LasttName' }
    address { FFaker::Address.street_address  }
    city { FFaker::Address.city }
    zip { rand(11111..99999) }
    country { 'Country' }
    phone { '+' + rand(1111111..9999999).round(0).to_s }
    address_type { rand(0..1) }
  end
end
