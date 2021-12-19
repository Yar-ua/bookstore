RSpec.describe Checkouts::PaymentsController do
  describe '#show' do
    it_behaves_like 'checkout show'
  end

  describe '#update' do
    it_behaves_like 'checkout failed update' do
      let(:invalid_params) { { checkout: { credit_card_attributes: { number: '' } } } }
    end

    it_behaves_like 'checkout successful update' do
      let(:next_step_path) { checkouts_confirm_path }
      let(:valid_params) { { checkout: { credit_card_attributes: credit_card_attributes } } }
      let(:credit_card_attributes) { attributes_for(:credit_card) }
    end
  end
end
