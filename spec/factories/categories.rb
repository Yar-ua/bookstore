FactoryBot.define do
  
  CATEGORIES = ['Mobile Development', 'Photo', 'Web Design', 'Web Development']
  
  factory :category do
    name { CATEGORIES.sample }
  end
end
