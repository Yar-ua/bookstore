RSpec.describe 'Pages#index page' do
  before do
    visit(root_path)
  end

  it { expect(page).to have_content(I18n.t('home.get_started')) }
  it { expect(page).to have_content(I18n.t('home.welcome')) }
  it { expect(page).to have_content(I18n.t('home.best_sellers')) }

  it 'go to catalog page' do
    click_on('Get Started')
    expect(page).to have_current_path books_path
  end
end
