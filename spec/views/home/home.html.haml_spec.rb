require 'rails_helper'

RSpec.describe 'home/home.html.haml', type: :view do
  describe 'hame page' do
    before { render template: 'home/home' }

    describe 'have slider' do
      it { expect(rendered).to have_selector('.slider-item', maximum: 3) }
      it { expect(rendered).to have_button('Buy Now') }
    end
    
    describe 'have text content' do
      it { expect(rendered).to have_content('Welcome to our amazing Bookstore!') }
      it { expect(rendered).to have_button('Get Started') }
    end
    
    describe 'have cards' do
      it { expect(rendered).to have_content('Best Sellers') }
      it { expect(rendered).to have_selector('.best-sellers', count: 4) }
    end
  end
end
