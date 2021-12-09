require 'rails_helper'

RSpec.describe 'Showing reviews' do
  let!(:book) { create(:book) }
  let!(:review) { create(:review, book: book, status: :approved) }

  before do
    visit book_path(id: book.id)
  end

  describe 'shows 1 review' do
    it { expect(page).to have_content(review[:message]) }
    it { expect(page).to have_content(review[:score]) }
  end

  describe 'shows expected content' do
    it { expect(page).to have_css('span', class: 'img-circle', text: review.user.email.first.upcase) }
    it { expect(page).to have_content(review.title) }
    it { expect(page).to have_content(review.message) }
  end
end
