RSpec.describe Cart do
  describe 'associations' do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to have_many(:line_items) }
    it { is_expected.to belong_to(:coupon).optional }
  end
end
