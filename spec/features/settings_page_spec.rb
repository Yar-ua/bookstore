require 'rails_helper'

RSpec.describe 'Current user profile email and password settings page' do
  include Warden::Test::Helpers
  let(:user) { create(:user) }

  before do
    login_as user
    visit new_setting_path
    find('li', text: I18n.t('settings.privacy')).click
  end

  it { expect(page).to have_content(I18n.t('settings.settings')) }
  it { expect(page).to have_content(user.email) }

  context 'with privacy page' do
    let(:new_test_email) { attributes_for(:user)[:email] }
    let(:error_message) { I18n.t('settings.error') }
    let(:success_message_email) { I18n.t('settings.email_changed') }

    it { expect(page).to have_content(I18n.t('settings.enter_email')) }

    it 'when change on empty email' do
      fill_in 'user_email', with: ''
      click_on(I18n.t('settings.save_email'))
      expect(page).to have_content error_message
    end

    it 'when successfuly change email' do
      fill_in 'user_email', with: new_test_email
      click_on(I18n.t('settings.save_email'))
      expect(page).to have_content success_message_email
    end
  end

  context 'when change password' do
    let(:new_password) { '654321' }
    let(:error_message_password) { I18n.t('settings.wrong_password') }
    let(:successfuly_update_password_messave) { I18n.t('settings.changed_password') }

    it 'click on submit with empty field' do
      click_on(I18n.t('settings.save_password'))
      expect(page).to have_content error_message_password
    end

    it 'click on submit with wrong current password' do
      fill_in 'user_old_password', with: 'new_password'
      fill_in 'user_new_password', with: new_password
      fill_in 'user_confirm_password', with: new_password
      click_on(I18n.t('settings.save_password'))
      expect(page).to have_content error_message_password
    end

    it 'when click on submit with all valid fields' do
      fill_in 'user_old_password', with: user.password
      fill_in 'user_new_password', with: new_password
      fill_in 'user_confirm_password', with: new_password
      click_on(I18n.t('settings.save_password'))
      expect(page).to have_content successfuly_update_password_messave
    end
  end

  context 'when delete account' do
    let(:successfuly_deleted_account_message) { I18n.t('settings.deleted_account') }

    it 'when submit and delete account' do
      find('span', class: 'checkbox-icon').click
      find(:css, id: 'confirmButton').click
      expect(page).to have_content successfuly_deleted_account_message
    end
  end
end
