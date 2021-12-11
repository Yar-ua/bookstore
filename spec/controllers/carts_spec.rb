require 'rails_helper'

RSpec.describe CartsController do
  describe '#edit' do
    before do
      get :edit
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    let!(:current_cart) { create(:cart, line_items: [line_item]) }
    let(:line_item) { build(:line_item) }

    before do
      session[ShoppingCartService::CART_SESSION_KEY] = current_cart.id
      post :update, params: params
    end

    context 'when all fields are valid' do
      let(:params) { { cart: { line_items_attributes: [line_item.attributes] } } }

      it 'redirect to cart edit page' do
        expect(response).to redirect_to(edit_cart_path)
      end
    end

    context 'when has invalid field' do
      let(:params) { { cart: { line_items_attributes: [{ quantity: -1 }] } } }

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end
end
