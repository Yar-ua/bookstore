FactoryBot.define do
  factory :delivery do
    sequence :method do |number|
      "Delivery #{number}"
    end
    days { rand(1..5).round(0) }
    price { (6 - days) * rand(0.1..0.5).round(2) }
  end
end
