RSpec.describe BooksController do
  let(:book) { create(:book) }

  describe 'GET /index' do
    it 'returns http success' do
      get :index
      expect(response)
        .to have_http_status(:success)
        .and render_template(:index)
    end
  end

  describe 'GET /show' do
    before { get :show, params: { id: book.id } }

    it 'returns http success' do
      expect(response)
        .to have_http_status(:success)
        .and render_template(:show)
    end
  end

  describe 'when add_to_cart' do
    let!(:book) { create(:book) }
    let(:params) { { id: book.id, counter_form: counter_form } }

    before do
      request.headers['Accept'] = 'text/javascript'
      post :add_to_cart, params: params
    end

    context 'when all fields are valid' do
      let(:counter_form) { { quantity: 1 } }

      it 'stores cart_id in session' do
        expect(session[ShoppingCartService::CART_SESSION_KEY]).not_to be_nil
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the create template' do
        expect(response).to render_template(:add_to_cart)
      end
    end
  end
end
