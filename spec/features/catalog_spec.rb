RSpec.describe 'Catalog page', type: :feature do
  let!(:book) { create(:book) }

  before do
    visit(catalog_path)
  end

  it 'go to current book page' do
    first('.thumb-hover')
    find('a', class: 'thumb-hover-link book').click
    expect(page).to have_current_path book_path(book.id)
  end

  it 'go to book category' do
    find('#books')
    first('a', class: 'filter-link category', text: book.category.name).click
    expect(page).to have_current_path catalog_path(category_id: book.category.id)
  end

  it 'go to book sort' do
    find('a', class: 'filter-link sort', text: I18n.t('sort.popular')).click
    expect(page).to have_current_path catalog_path(sort: :popular)
  end
end
