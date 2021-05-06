require 'rails_helper'

describe 'Sign up page', type: :feature do
  let(:empty_field) { "can't be blank" }
  let(:error_wrong_confirm_password) { "doesn't match Password" }
  let(:valid_attributes) { attributes_for(:user) }

  before do
    visit new_user_registration_path
  end

  it 'click to sign up with clear fields' do
    fill_in 'user[email]', with: ''
    fill_in 'user[password]', with: ''
    fill_in 'user[password_confirmation]', with: ''
    click_button(I18n.t('session.signup'))
    expect(page).to have_content empty_field
  end

  it 'click to sign up with wrong email' do
    fill_in 'user[email]', with: ''
    fill_in 'user[password]', with: valid_attributes[:password]
    fill_in 'user[password_confirmation]', with: valid_attributes[:password]
    click_button(I18n.t('session.signup'))
    expect(page).to have_content empty_field
  end

  it 'click to sign up with wrong password' do
    fill_in 'user[email]', with: valid_attributes[:email]
    fill_in 'user[password]', with: ''
    fill_in 'user[password_confirmation]', with: ''
    click_button(I18n.t('session.signup'))
    expect(page).to have_content empty_field
  end

  it 'click to sign up with wrong confirm password' do
    fill_in 'user[email]', with: valid_attributes[:email]
    fill_in 'user[password]', with: valid_attributes[:password]
    fill_in 'user[password_confirmation]', with: ''
    click_button(I18n.t('session.signup'))
    expect(page).to have_content error_wrong_confirm_password
  end

  it 'when all fields right' do
    fill_in 'user[email]', with: valid_attributes[:email]
    fill_in 'user[password]', with: valid_attributes[:password]
    fill_in 'user[password_confirmation]', with: valid_attributes[:password]
    click_button(I18n.t('session.signup'))
    expect(page).to have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
  end

  it 'when click to log in' do
    find('a', class: 'in-gold-500', text: I18n.t('session.login')).click
    expect(page).to have_current_path new_user_session_path
  end
end
