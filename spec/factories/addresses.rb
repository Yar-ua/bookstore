FactoryBot.define do
  factory :address do
    first_name { "MyString" }
    last_name { "MyString" }
    address { "MyString" }
    city { "MyString" }
    zip { 1 }
    country { "MyString" }
    phone { "MyString" }
    address_type { 1 }
    user { nil }
  end
end
