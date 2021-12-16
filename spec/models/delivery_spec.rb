RSpec.describe Delivery, :step_ten do
  describe 'associations' do
    it { is_expected.to validate_presence_of(:method) }
  end
end
