RSpec.describe OrderFactoryService, :step_ten do
  subject(:order_factory) { described_class.new(cart, checkout) }

  let!(:user) { create(:user) }
  let!(:cart) { create(:cart, :filled, user: user) }
  let!(:checkout) { create(:checkout, user: user) }

  describe '#create_order!' do
    let(:order) { order_factory.create_order! }

    it { expect(order).to be_a(Order) }
    it { expect(order.amount).to eq(cart.amount) }
    it { expect(order.total).to eq(cart.total) }
    it { expect(order.credit_card).to eq(checkout.credit_card) }
    it { expect(order.billing_address.address).to eq(checkout.billing_address.address) }
    it { expect(order.shipping_address.address).to eq(checkout.shipping_or_billing_address.address) }
  end
end
