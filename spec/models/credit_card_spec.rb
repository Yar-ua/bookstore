RSpec.describe CreditCard, :step_ten do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    let(:valid_number) do
      CreditCard::CARD_BRANDS.map { |brand| CreditCardValidations::Factory.random(brand) }
    end
    let(:invalid_numbers) do
      [FFaker::String.from_regexp(/\d{5}/),
       FFaker::String.from_regexp(/\d{20}/),
       FFaker::String.from_regexp(/\d{4}-\d{4}-\d{4}-\d{4}/),
       FFaker::String.from_regexp(/\w{16}/)]
    end
    let(:valid_cvv) { [FFaker::String.from_regexp(/\d{3}/), FFaker::String.from_regexp(/\d{4}/)] }
    let(:invalid_cvv) do
      [FFaker::String.from_regexp(/\d{2}/),
       FFaker::String.from_regexp(/\d{5}/),
       FFaker::String.from_regexp(/\w{3}/)]
    end
    let(:valid_owner_name) { FFaker::Name.html_safe_name }
    let(:invalid_owner_names) { [FFaker::NameUA.name, FFaker::Address.street_address] }
    let(:valid_expiration_date) { FFaker::Bank.card_expiry_date }
    let(:invalid_expiration_date) { %w[20/20 2/20 00/2] }

    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to allow_values(*valid_number).for(:number) }
    it { is_expected.not_to allow_values(*invalid_numbers).for(:number) }

    it { is_expected.to validate_presence_of(:cvv) }
    it { is_expected.to allow_values(*valid_cvv).for(:cvv) }
    it { is_expected.not_to allow_values(*invalid_cvv).for(:cvv) }

    it { is_expected.to validate_presence_of(:cardholder_name) }
    it { is_expected.to allow_value(valid_owner_name).for(:cardholder_name) }
    it { is_expected.not_to allow_values(invalid_owner_names).for(:cardholder_name) }

    it { is_expected.to validate_presence_of(:expiration_date) }
    it { is_expected.to allow_value(valid_expiration_date).for(:expiration_date) }
    it { is_expected.not_to allow_value(invalid_expiration_date).for(:expiration_date) }
  end
end