RSpec.describe PagesController do
  describe 'GET /pages' do
    before { get :index }

    it 'successfully renders the index page' do
      expect(response)
        .to have_http_status(:success)
        .and render_template(:index)
    end
  end
end
