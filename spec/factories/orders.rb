FactoryBot.define do
  factory :order do
    status { Order.aasm.states.map(&:name).sample }
    credit_card { association(:credit_card, user: user) }
    user
    coupon
    delivery

    after(:build) do |checkout|
      checkout.billing_address = build(:billing_address)
      checkout.shipping_address = build(:shipping_address)
    end
  end
end