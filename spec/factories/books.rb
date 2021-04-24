FactoryBot.define do
  factory :book do
    association :category, factory: :category

    title { FFaker::Book.title }
    description { FFaker::Book.description(8) }
    year { rand(1980..2021) }
    quantity { rand(1..100) }
    price { rand(3.50..99.99).round(2) }
    height { rand(6.4..10.0).round(1) }
    width { rand(4.4..8.0).round(1) }
    depth { rand(0.5..2.0).round(1) }
    materials { %w[papers silk].sample }
  end
end
