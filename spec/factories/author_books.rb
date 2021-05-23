FactoryBot.define do
  factory :author_book do
    author { association :author }
    book { association :book }
  end
end
