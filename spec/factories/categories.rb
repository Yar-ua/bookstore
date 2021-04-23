FactoryBot.define do
  factory :category do
    name { FFaker::Book.unique.genre }
  end
end
