RSpec.describe 'Current book page', type: :feature do
  let(:author) { create(:author) }
  let(:book) { create(:book) }
  let(:authorship) { AuthorBook.create(book_id: book.id, author_id: author.id) }
  let(:dimensions) { "H: #{book.height}\" x W: #{book.width}\" x D: #{book.depth}\"" }

  before do
    visit books_path
    visit book_path(book)
  end

  it { expect(page).to have_content(book.description[0..BookDecorator::VISIBLE_LENGTH_DESCRIPTION_BOOK]) }
  it { expect(page).to have_content(dimensions) }

  it 'when click on read more' do
    find('a', id: 'btn_read_more', text: I18n.t('book.read_more')).click
    expect(page).to have_selector 'a', text: I18n.t('book.hide_read_more')
  end
end
