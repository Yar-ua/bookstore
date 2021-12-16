RSpec.describe Checkout, :step_ten do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:delivery).optional }
    it { is_expected.to belong_to(:credit_card).optional }
  end
end
