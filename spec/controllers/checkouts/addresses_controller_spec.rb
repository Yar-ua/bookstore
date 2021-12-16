RSpec.describe Checkouts::AddressesController, :step_ten do
  describe '#show' do
    it_behaves_like 'checkout show'
  end

  describe '#update' do
    it_behaves_like 'checkout failed update' do
      let(:invalid_params) { { checkout: { billing_address_attributes: { address: nil } } } }
    end

    it_behaves_like 'checkout successful update' do
      let(:next_step_path) { checkouts_delivery_path }
      let(:valid_params) do
        { checkout: {
          billing_address_attributes: billing_address_attributes,
          shipping_address_attributes: shipping_address_attributes
        } }
      end
      let(:billing_address_attributes) { attributes_for(:billing_address) }
      let(:shipping_address_attributes) { attributes_for(:shipping_address) }
    end
  end
end
