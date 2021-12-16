FactoryBot.define do
  factory :credit_card do
    number { CreditCardValidations::Factory.random(CreditCard::CARD_BRANDS.sample) }
    cvv { FFaker::String.from_regexp(/\d{3}/) }
    expiration_date { FFaker::Bank.card_expiry_date }
    cardholder_name { FFaker::Name.html_safe_name }
    user
  end
end
