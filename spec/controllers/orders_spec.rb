RSpec.describe OrdersController do
  let(:user) { create(:user) }

  describe '#index' do
    let!(:orders) { create_list(:order, 2, user: user) }

    before do
      create_list(:order, 2)
    end

    context 'when user is not signed in' do
      before do
        get :index
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is signed in' do
      before do
        sign_in user
        get :index
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end

      it 'decorates orders' do
        expect(assigns(:orders)).to be_decorated
      end

      it 'returns expected orders size' do
        expect(assigns(:orders).size).to eq(orders.size)
      end
    end
  end

  describe '#show' do
    let!(:order) { create(:order, user: user) }

    context 'when user is not signed in' do
      before do
        get :show, params: { id: order.id }
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is signed in' do
      before do
        sign_in user
        get :show, params: { id: order.id }
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end

      it 'decorates book' do
        expect(assigns(:order)).to be_decorated
      end
    end

    context 'when signed user try to show another user order' do
      let!(:another_user_order) { create(:order) }

      before do
        sign_in user
      end

      it "raises #{ActiveRecord::RecordNotFound} error" do
        expect { get :show, params: { id: another_user_order.id } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
