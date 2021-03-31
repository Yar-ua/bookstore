require 'rails_helper'

RSpec.describe 'home/home.html.haml', type: :view do
  describe 'hame page' do
    it 'aaa' do
      render template: 'home/home'
      expect(rendered).to include('Welcome to our amazing Bookstore!')
    end
  end
end
