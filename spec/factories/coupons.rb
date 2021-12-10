FactoryBot.define do
  factory :coupon do
    sequence :amount do |number|
      number
    end
    code { "SALE#{amount}" }
  end
end
