require 'rails_helper'

RSpec.describe 'Posting review', js: true do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:review) { attributes_for(:review) }
  
  context 'when visitor is not signed in' do
    before do
      login_as user
      visit book_path(book)
    end
    
    it 'then has form error' do
      click_button(I18n.t('shared.submit'))
      expect(page).to have_content("can't be blank")
    end

    context 'when form fill' do
      before do
        fill_review_form(review)
        click_button(I18n.t('shared.submit'))
      end
      
      it 'has content' do
        expect(page).to have_text(I18n.t('devise.failure.unauthenticated'))
      end
    end
  end

  context 'when visitor is signed in' do
    let!(:user) { create(:user) }
    
    before do
      login_as user, scope: :user
      visit book_path(book)
      fill_review_form(review)
    end
    
    it 'when invalid form then has success notice' do
      fill_in 'review_score', with: 50
      click_button(I18n.t('shared.submit'))
      expect(page).to have_content('is not included in the list')
    end
    
    it 'when valid form then has success notice' do
      click_button(I18n.t('shared.submit'))
      expect(page).to have_text(I18n.t('reviews.create.success'))
    end
  end

  def fill_review_form(review)
    fill_in 'review_score', with: review[:score]
    fill_in 'review_title', with: review[:title]
    fill_in 'review_message', with: review[:message]
  end
end