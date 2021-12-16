RSpec.describe CheckoutFactoryService, :step_ten do
  subject(:checkout_factory) { described_class.new(user) }

  let!(:user) { create(:user, :with_address) }

  describe '#create_checkout!' do
    let(:checkout) { checkout_factory.create_checkout! }

    it { expect(checkout).to be_a(Checkout) }
    it { expect(checkout.billing_address.address).to eq(user.billing_address.address) }
    it { expect(checkout.shipping_address.address).to eq(user.shipping_address.address) }
  end
end
