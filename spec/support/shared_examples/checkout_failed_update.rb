RSpec.shared_examples 'checkout failed update' do
  let(:user) { create(:user) }

  before do
    stub_cart(:filled, user: user)
    sign_in user
  end

  context 'when has invalid fields' do
    before do
      put :update, params: invalid_params
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end
end