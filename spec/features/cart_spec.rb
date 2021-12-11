require 'rails_helper'

RSpec.describe 'Cart', js: true do
  let(:book) { create(:book) }

  before do
    visit book_path(book)
    click_button(I18n.t('book.add_to_cart'))
  end

  describe 'add to cart' do
    it 'shows expected cart product quantity' do
      expect(page).to have_css('.shop-link.hidden-xs', text: 1)
    end
  end

  describe 'visit cart edit page' do
    before do
      visit edit_cart_path
    end

    describe 'shows expected content' do
      it { expect(page).to have_css '.hidden-xs .cart_items table tbody tr', count: 1 }
      it { expect(page).to have_css 'img' }
      it { expect(page).to have_content(book.title) }
      it { expect(page).to have_content(book.decorate.price_to_currency) }
      it { expect(page).to have_css 'td:nth-of-type(4)' }
      it { expect(page).to have_css '.close' }
    end
  end

  describe 'remove product' do
    before do
      visit edit_cart_path
    end

    it do
      find(class: 'general-cart-close').click
      expect(page).to have_no_css('label.close')
    end
  end

  describe 'add card' do
    before do
      visit edit_cart_path
      fill_in 'cart[coupon_code]', with: coupon.code
      click_button(I18n.t('carts.coupon_form.submit'))
    end

    context 'when coupon is invalid' do
      let(:coupon) { build(:coupon) }

      it 'shows errors' do
        expect(page).to have_css('.invalid-feedback')
      end
    end

    context 'when coupon is valid' do
      let!(:coupon) { create(:coupon) }
      let(:expected_discount) { book.price * coupon.amount / 100 }

      it 'shows discount' do
        expect(page).to have_content(expected_discount.to_s.to_f.round(2))
      end
    end
  end
end
