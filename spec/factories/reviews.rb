FactoryBot.define do
  factory :review do
    user { association :user }
    book { association :book }
    score { rand(Review::SCORE_RANGE) }
    title { FFaker::Name.name }
    message { FFaker::Lorem.paragraph }
    status { Review.statuses.values.sample }
  end
end
