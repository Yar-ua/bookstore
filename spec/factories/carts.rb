FactoryBot.define do
  factory :cart do
    trait :with_user do
      user
    end

    trait :with_coupon do
      coupon
    end

    transient do
      line_items_size { rand(1..10) }
    end

    trait :filled do
      after(:build) do |cart, _evaluator|
        book = create(:book)
        book.save
        line_item = build(:line_item, book: book)
        cart.line_items.build { line_item }
        cart.line_items.last.book_id = book.id
        cart.save!
      end
    end
  end
end
