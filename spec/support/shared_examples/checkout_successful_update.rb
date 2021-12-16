RSpec.shared_examples 'checkout successful update' do
  let(:user) { create(:user) }

  before do
    stub_cart(:filled, user: user)
    sign_in user
  end

  context 'when all fields are valid' do
    before do
      put :update, params: valid_params
    end

    it 'redirects to next step' do
      expect(response).to redirect_to(next_step_path)
    end
  end
end