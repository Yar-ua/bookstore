RSpec.describe Coupon do
  subject(:coupon) { build(:coupon) }

  describe 'associations' do
    it { expect(coupon).to have_many(:carts).dependent(:nullify) }
  end

  describe 'validations' do
    %i[code amount].each do |field|
      it { expect(coupon).to validate_presence_of(field) }
    end

    it { expect(coupon).to validate_uniqueness_of(:code) }

    it do
      expect(coupon).to validate_numericality_of(:amount)
        .is_greater_than_or_equal_to(Coupon::AMOUNT_RANGE.min)
        .is_less_than_or_equal_to(Coupon::AMOUNT_RANGE.max)
    end
  end
end
