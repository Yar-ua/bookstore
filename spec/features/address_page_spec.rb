require 'rails_helper'

RSpec.describe 'Current user profile email and password settings page' do
  let(:user) { create(:user) }
  let(:billing) { attributes_for(:address, :billing) }

  before do
    login_as user, scope: :user
    visit new_setting_path
    find('li', text: I18n.t('settings.address')).click
  end

  it { expect(page).to have_current_path new_setting_path }
  it { expect(page).to have_selector 'a', text: I18n.t('settings.address') }

  it { expect(page).to have_selector 'h3', text: I18n.t('settings.billing_address') }
  it { expect(page).to have_selector 'h3', text: I18n.t('settings.shipping_address') }

  it { expect(page).to have_field 'billing_first_name', placeholder: 'Please enter your first name' }
  it { expect(page).to have_field 'billing_last_name' }
  it { expect(page).to have_field 'billing_address' }
  it { expect(page).to have_field 'billing_city' }
  it { expect(page).to have_field 'billing_zip' }
  it { expect(page).to have_select 'billing_country' }
  it { expect(page).to have_field 'billing_phone' }
  it { expect(page).to have_button(id: 'save_billing_button') }
  it { expect(page).to have_field 'shipping_first_name' }
  it { expect(page).to have_field 'shipping_last_name' }
  it { expect(page).to have_field 'shipping_city' }
  it { expect(page).to have_field 'shipping_phone' }
  it { expect(page).to have_button(id: 'save_shipping_button') }

  context 'when create and update billing' do
    let(:billing) { attributes_for(:address, :billing, user_id: user.id) }

    before do
      fill_in 'billing[first_name]', with: billing[:first_name]
      fill_in 'billing[last_name]', with: billing[:last_name]
      fill_in 'billing[address]', with: billing[:address]
      fill_in 'billing[city]', with: billing[:city]
      fill_in 'billing[zip]', with: billing[:zip]
      fill_in 'billing[first_name]', with: billing[:phone]
      find(id: 'save_billing_button', class: 'btn').click
    end

    it { expect(Address.count).to eq(0) }
    it { expect(page).to have_content I18n.t('settings.address_was_changed') }
  end

  context 'when update billing' do
    let(:new_billing) { user.addresses(attributes_for(:address, :billing, user_id: user.id)) }

    before do
      fill_in 'billing[first_name]', with: 'Abcabc'
      find(id: 'save_billing_button', class: 'btn').click
    end

    it { expect(Address.count).to eq(0) }
    it { expect(page).to have_content I18n.t('settings.address_was_changed') }
  end
end
