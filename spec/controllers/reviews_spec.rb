require 'rails_helper'

RSpec.describe ReviewsController do
  describe '#create' do
    let!(:book) { create(:book) }
    let(:invalid_review) { attributes_for(:review, title: '').except(:status) }
    let(:review) { attributes_for(:review).except(:status) }

    context 'when user not signed in' do
      before do
        post :create, params: { book_id: book.id }
      end

      it 'redirects to sign_in page' do
        expect(response).to redirect_to(new_user_session_url)
      end

      it 'stores flash alert message' do
        expect(flash[:alert]).to eq(I18n.t('devise.failure.unauthenticated'))
      end
    end

    context 'when user signed in' do
      let!(:user) { create(:user) }

      before do
        sign_in user
      end

      context 'when has invalid field' do
        it 'render template' do
          post :create, params: { book_id: book.id, review: invalid_review }
          expect(response).to render_template('books/show')
        end
      end

      context 'when all fields are valid' do
        before do
          post :create, params: { book_id: book.id, review: review }
        end

        it 'redirects to book page' do
          expect(response).to redirect_to(book_url(id: book.id))
        end

        it 'stores flash notice message' do
          expect(flash[:success]).to eq(I18n.t('reviews.create.success'))
        end

        it 'stores review' do
          expect(assigns(:review)).to be_persisted
        end
      end
    end
  end
end
