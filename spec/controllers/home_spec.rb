RSpec.describe HomeController do
  describe 'GET /home' do
    before { get :index }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    
    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end
end
