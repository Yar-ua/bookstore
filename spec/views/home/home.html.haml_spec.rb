require 'rails_helper'

RSpec.describe 'home/home.html.haml', type: :view do
  describe 'hame page' do
    before { render template: 'home/home' }

    it { expect(rendered).to have_content('Welcome to our amazing Bookstore!') }
    it { expect(rendered).to have_content('Best Sellers') }
    it { expect(rendered).to have_selector('#slider') }
    it { expect(rendered).to have_button('Buy Now') }
  end
end
