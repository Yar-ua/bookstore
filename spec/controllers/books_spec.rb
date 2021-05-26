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
end
