require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe 'Current user profile email and password settings page' do
  let(:user) { create(:user) }

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
  
  
  
  context 'when billing' do
    let(:billing) { user.addresses.create(attributes_for(:address, :billing)) }

    # it 'when save billing address with empty fields' do
    #     page.first('.address_first_name').set('')
    #             # first('input[type=submit]').click
    #             click_on('Save billing')
    #     expect(page).to have_content "can't be blank"
    # end
    
    it 'billing address exists' do
  
      expect(page).to have_field 'billing_form_first_name'
      # expect(page).to have_field 'edit_billing_form[last_name]'
      # expect(page).to have_field 'edit_billing_form[address]'
      # expect(page).to have_field 'edit_billing_form[city]'
      # expect(page).to have_field 'edit_billing_form[zip]'
      # expect(page).to have_field 'edit_billing_form[country]'
      # expect(page).to have_field 'edit_billing_form[phone]'
    end
    # it 'billing address exists' do
    #   billing
    #   visit new_setting_path

    
    
    # context 'when billing' do
    #   let(:billing) { user.addresses.create(attributes_for(:address, :billing)) }
  
    #   it 'when save billing address with empty fields' do
    #     first('input[type=submit]').click
    #     expect(page).to have_content "can't be blank, must write with big letter"
    #   end
  
    #   it 'billing address exists' do
    #     billing
    #     visit new_setting_path
  
    #     expect(page).to have_field 'billing_form[first_name]', with: billing.first_name
    #     expect(page).to have_field 'billing_form[last_name]', with: billing.last_name
    #     expect(page).to have_field 'billing_form[address]', with: billing.address
    #     expect(page).to have_field 'billing_form[city]', with: billing.city
    #     expect(page).to have_field 'billing_form[zip]', with: billing.zip
    #     expect(page).to have_field 'billing_form[country]', with: billing.country
    #     expect(page).to have_field 'billing_form[phone]', with: billing.phone
    #   end
  
    #   it 'valid input' do
    #     first('#billing_form_first_name').set valid_attributes[:first_name]
    #     first('#billing_form_last_name').set valid_attributes[:last_name]
    #     first('#billing_form_address').set valid_attributes[:address]
    #     first('#billing_form_city').set valid_attributes[:city]
    #     fill_in 'billing_form[zip]', with: valid_attributes[:zip]
    #     first('#billing_form_phone').set valid_attributes[:phone]
    #     first('input[type=submit]').click
    #     expect(Address.count).to eq(1)
    #   end
    # end
    
    
    
  end

  # context 'when shipping' do
  #   let(:shipping) { user.addresses.create(attributes_for(:address, :shipping)) }

  #   it 'when save billing address with empty fields' do
  #     all('input[type=submit]').last.click
  #     expect(page).to have_content "can't be blank, must write with big letter"
  #   end

  #   it 'shipping address exists' do
  #     shipping
  #     visit new_setting_path

  #     expect(page).to have_field 'shipping_form[first_name]', with: shipping.first_name
  #     expect(page).to have_field 'shipping_form[last_name]', with: shipping.last_name
  #     expect(page).to have_field 'shipping_form[address]', with: shipping.address
  #     expect(page).to have_field 'shipping_form[city]', with: shipping.city
  #     expect(page).to have_field 'shipping_form[zip]', with: shipping.zip
  #     expect(page).to have_field 'shipping_form[country]', with: shipping.country
  #     expect(page).to have_field 'shipping_form[phone]', with: shipping.phone
  #   end

  #   it 'valid input' do
  #     first('#shipping_form_first_name').set valid_attributes[:first_name]
  #     first('#shipping_form_last_name').set valid_attributes[:last_name]
  #     first('#shipping_form_address').set valid_attributes[:address]
  #     first('#shipping_form_city').set valid_attributes[:city]
  #     fill_in 'shipping_form[zip]', with: valid_attributes[:zip]
  #     first('#shipping_form_phone').set valid_attributes[:phone]
  #     all('input[type=submit]').last.click
  #     expect(Address.count).to eq(1)
  #   end
  # end
  
  
  
  
  
  
  
end

# require 'rails_helper'
# include Warden::Test::Helpers

# RSpec.describe 'Current user profile email and password settings page' do
#   let(:user) { create(:user) }

#   before do
#     login_as user
#     visit new_setting_path
#     find('li', text: I18n.t('settings.privacy')).click
#   end

#   it 'visit settings page' do
#     expect(page).to have_content(I18n.t('settings.settings'))
#     expect(page).to have_content(user.email)
#   end
  
#   context 'privacy partial' do
#     let(:new_test_email) { attributes_for(:user)[:email] }
#     let(:error_message) { I18n.t('settings.error') }
#     let(:success_message_email) { I18n.t('settings.email_changed') }
    
#     it { expect(page).to have_content(I18n.t('settings.enter_email')) }
    
#     it 'when change on empty email' do
#       fill_in 'user_email', with: ''
#       click_on(I18n.t('settings.save_email'))
#       expect(page).to have_content error_message
#     end

#     it 'when successfuly change email' do
#       fill_in 'user_email', with: new_test_email
#       click_on(I18n.t('settings.save_email'))
#       expect(page).to have_content success_message_email
#     end
#   end
  
#   context 'when change password' do
#     let(:new_password) { '654321' }
#     let(:error_message_password) { I18n.t('settings.wrong_password') }
#     let(:successfuly_update_password_messave) { I18n.t('settings.changed_password') }

#     it 'click on submit with empty field' do
#       click_on(I18n.t('settings.save_password'))
#       expect(page).to have_content error_message_password
#     end

#     it 'click on submit with wrong current password' do
#       fill_in 'user_old_password', with: 'new_password'
#       fill_in 'user_new_password', with: new_password
#       fill_in 'user_confirm_password', with: new_password
#       click_on(I18n.t('settings.save_password'))
#       expect(page).to have_content error_message_password
#     end

#     it 'click on submit with all valid fields' do
#       fill_in 'user_old_password', with: user.password
#       fill_in 'user_new_password', with: new_password
#       fill_in 'user_confirm_password', with: new_password
#       click_on(I18n.t('settings.save_password'))
#       expect(page).to have_content successfuly_update_password_messave
#     end
#   end
  
#   context 'delete account' do
#     let(:successfuly_deleted_account_message) { I18n.t('controllers.deleted_account') }

#     it 'when submit and delete account' do
#       find('span', class: 'checkbox-icon').click
#       find(:css, id: 'confirmButton').click
#       expect(page).to have_content successfuly_deleted_account_message
#     end
#   end

# end
