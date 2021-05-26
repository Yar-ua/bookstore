CATEGORIES = ['Mobile Development', 'Photo', 'Web Design', 'Web Development'].freeze

FactoryBot.define do
  factory :category do
    name { CATEGORIES.sample }
  end
end
