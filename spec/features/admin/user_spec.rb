require 'rails_helper'

RSpec.describe 'Author section', type: :feature, js: true do
  let!(:admin_user) { create(:admin_user) }
  let!(:user) { create(:admin_user) }

  before do
    login_as admin_user
    visit admin_admin_users_path
  end

  it { expect(page).to have_current_path('/admin/admin_users') }
  it { expect(page).to have_content(user.email) }

  context 'when click view on the column' do
    before do
      find_link('View', href: admin_admin_user_path(user)).click
    end

    it { expect(page).to have_content(user[:email]) }
  end

  context 'when click edit on the column' do
    before do
      find_link('Edit', href: edit_admin_admin_user_path(user)).click
    end

    it { expect(page).to have_content('Edit Admin User') }
    it { expect(page).to have_selector 'li', id: 'admin_user_submit_action' }

    context 'when enter valid data and save changes' do
      let(:email) { FFaker::Internet.email }

      before do
        fill_in 'admin_user[email]', with: email
        fill_in 'admin_user[password]', with: user.password
        fill_in 'admin_user[password_confirmation]', with: user.password
        find('li', id: 'admin_user_submit_action').click
      end

      it { expect(page).to have_content('Admin user was successfully updated.') }
    end
  end
end
