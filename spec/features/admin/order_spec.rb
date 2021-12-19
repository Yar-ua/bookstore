require 'rails_helper'

RSpec.describe 'Admin Orders', type: :feature do
  let(:admin_user) { create(:admin_user) }
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user, status: :in_progress) }

  before do
    login_as admin_user
    order
  end

  describe 'Index page' do
    before do
      visit admin_orders_path
    end

    context 'when contains expected content' do
      it { expect(page).to have_content(order.decorate.created_at_formatted) }
      it { expect(page).to have_content(order.decorate.status_name) }
    end
  end

  describe 'Show page' do
    before do
      visit admin_order_path(order)
    end

    context 'when contains expected content' do
      it { expect(page).to have_content(user.email) }
      it { expect(page).to have_content(order.decorate.created_at_formatted) }
    end
  end
end
