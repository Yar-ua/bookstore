FactoryBot.define do
  factory :line_item do
    association :book, factory: :book
    quantity { rand(1..10) }

    after(:build) do |line_item|
      line_item.price = line_item.book.price
    end
  end
end
