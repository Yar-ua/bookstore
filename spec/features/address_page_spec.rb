require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe 'Current user profile email and password settings page' do
  let(:user) { create(:user) }
  let(:billing) { attributes_for(:address, :billing) }

  before do
    login_as user
    visit new_setting_path
    find('li', text: I18n.t('settings.address')).click
  end
  
  it 'when go to address page' do
    expect(page).to have_current_path new_setting_path
    expect(page).to have_selector 'a', text: I18n.t('settings.address')
  end
  
  it 'visit address page' do
    expect(page).to have_selector 'h3', text: I18n.t('settings.billing_address')
    expect(page).to have_selector 'h3', text: I18n.t('settings.shipping_address')
  end
  
  it 'billing address have billing felds' do
    expect(page).to have_field 'billing_first_name', placeholder: 'Please enter your first name'
    expect(page).to have_field 'billing_last_name'
    expect(page).to have_field 'billing_address'
    expect(page).to have_field 'billing_city'
    expect(page).to have_field 'billing_zip'
    expect(page).to have_select 'billing_country'
    expect(page).to have_field 'billing_phone'
    expect(page).to have_button(id: 'save_billing_button')
  end

  it 'billing address have shipping felds' do
    expect(page).to have_field 'shipping_first_name'
    expect(page).to have_field 'shipping_last_name'
    expect(page).to have_field 'shipping_address'
    expect(page).to have_field 'shipping_city'
    expect(page).to have_field 'shipping_zip'
    expect(page).to have_select 'shipping_country'
    expect(page).to have_field 'shipping_phone'
    expect(page).to have_button(id: 'save_shipping_button')
  end
  
  context 'when create and update billing' do
    let(:billing) { user.addresses.create(attributes_for(:address, :billing)) }
    
    it 'valid input' do
      fill_in 'billing[first_name]', with: billing[:first_name]
      fill_in 'billing[last_name]', with: billing[:last_name]
      fill_in 'billing[address]', with: billing[:address]
      fill_in 'billing[city]', with: billing[:city]
      fill_in 'billing[zip]', with: billing[:zip]
      fill_in 'billing[first_name]', with: billing[:phone]
      find(id: 'save_billing_button', class: 'btn').click
      expect(Address.count).to eq(1)
      expect(page).to have_content I18n.t('settings.address_was_changed')
    end
    
    it 'valid input' do
      fill_in 'billing[first_name]', with: 'Abcabc'
      find(id: 'save_billing_button', class: 'btn').click
      expect(Address.count).to eq(0)
      expect(page).to have_content I18n.t('settings.address_was_changed')
    end

  end
end
