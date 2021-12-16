FactoryBot.define do
  factory :checkout do
    stage { Checkout::STAGES.values.sample }
    use_billing_address { FFaker::Boolean.maybe }
    credit_card { association(:credit_card, user: user) }
    user
    delivery

    after(:build) do |checkout|
      checkout.billing_address = build(:billing_address)
      checkout.shipping_address = build(:shipping_address)
    end
  end
end
