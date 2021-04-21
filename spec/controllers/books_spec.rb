require 'rails_helper'

RSpec.describe BooksController do
  let(:book) { FactoryBot.create(:book, category_id: FactoryBot.create(:category, name: 'Photo').id) }

  describe 'GET /index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    before { get :show, params: { id: book.id } }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
