RSpec.describe LineItem do
  describe 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:cart) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:book) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than_or_equal_to(described_class::MIN_QUANTITY) }
  end
end
