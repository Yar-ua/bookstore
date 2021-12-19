RSpec.describe Checkouts::DeliveriesController do
  describe '#show' do
    it_behaves_like 'checkout show'
  end

  describe '#update' do
    it_behaves_like 'checkout successful update' do
      let(:next_step_path) { checkouts_payment_path }
      let(:valid_params) { { checkout: { delivery_id: delivery.id } } }
      let(:delivery) { create(:delivery) }
    end

    it_behaves_like 'checkout failed update' do
      let(:invalid_params) { { checkout: { delivery_id: nil } } }
    end
  end
end
