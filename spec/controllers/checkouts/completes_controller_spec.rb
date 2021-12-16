RSpec.describe Checkouts::CompletesController, :step_ten do
  describe '#show' do
    context 'when user is not signed in' do
      before do
        get :show
      end

      it 'redirects to checkout login page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is signed in' do
      let(:user) { create(:user) }
      let!(:user_orders) { create_list(:order, 2, user: user) }

      before do
        create_list(:order, 3)
        sign_in user
        get :show
      end

      it 'has last order instance' do
        expect(assigns(:order)).to eq(user_orders.last)
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end
    end
  end
end
