RSpec.shared_examples 'checkout show' do
  context 'when user is not signed in' do
    before do
      get :show
    end

    it 'redirects to checkout login page' do
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'when cart is empty' do
    let(:user) { create(:user) }

    before do
      sign_in user
      get :show
    end

    it 'redirects to checkout login page' do
      expect(response).to redirect_to(edit_cart_path)
    end
  end

  context 'when user signed in' do
    let(:user) { create(:user) }
    let!(:cart) { create(:cart, :filled, user: user) }

    before do
      sign_in user
      # stub_cart(:filled, user: user)
      # cart = create(:cart, :filled, user: user)
      # binding.pry
      session[ShoppingCartService::CART_SESSION_KEY] = cart.id
      # cart
      get :show
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'assings checkout' do
      expect(assigns(:checkout)).to be_a(Checkout)
    end

    it 'stores checkout_id in session' do
      expect(session[:checkout_id]).not_to be_nil
    end
  end
end