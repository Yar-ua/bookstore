FactoryBot.define do
  factory :book do
    association :category, factory: :category
    
    title { Faker::Book.title }
    description { Faker::Commerce.department(max: 5) }
    year { Faker::Number.between(from: 1980, to: 2020) }
    quantity { Faker::Number.between(from: 1, to: 100) }
    price { Faker::Number.between(from: 5, to: 100) }
    height { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    width { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    depth { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    materials { ['papers', 'silk'].sample }
  end
end
