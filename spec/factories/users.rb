FactoryBot.define do
  factory :user do
    email { FFaker::Internet.unique.email }
    password { FFaker::Internet.unique.password }
    password_confirmation { password }
    confirmed_at { Time.now }
  end
end
