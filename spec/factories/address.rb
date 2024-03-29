FactoryBot.define do
  factory :address do
    association :addressable, factory: :user

    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_name }
    city { FFaker::Address.city }
    zip { rand(11_111..99_999) }
    country { 'UA' }
    phone { "+#{rand(11_111_111_111..99_999_999_999).round(0)}" }

    factory :billing_address, class: 'BillingAddress'
    factory :shipping_address, class: 'ShippingAddress'
  end
end
