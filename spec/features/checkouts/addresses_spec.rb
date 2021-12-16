RSpec.describe 'Billing and Shipping addresses' do
  let!(:user) { create(:user, billing_address: user_billing_address, shipping_address: user_shipping_address) }
  let(:user_billing_address) { nil }
  let(:user_shipping_address) { nil }

  before do
    stub_cart(user, :filled, :with_coupon)
    stub_checkout(user)
    login_as user, scope: :user
    visit checkouts_address_path
  end

  describe 'shows billing and shipping address forms' do
    context 'when no user billing and shipping address info' do
      it { expect(find('#checkout_billing_address_attributes_first_name').value).to eq nil }
      it { expect(find('#checkout_shipping_address_attributes_first_name').value).to eq nil }
    end

    context 'when user has billing and shipping address info' do
      let(:user_billing_address) { build(:billing_address) }
      let(:user_shipping_address) { build(:shipping_address) }

      it {
        expect(find('#checkout_billing_address_attributes_first_name').value).to eq(user_billing_address.first_name)
      }

      it {
        expect(find('#checkout_shipping_address_attributes_first_name').value).to eq(user_shipping_address.first_name)
      }
    end
  end

  describe 'saves billing and shipping address info' do
    before do
      fill_in 'checkout_billing_address_attributes_first_name', with: billing_address.first_name
      fill_in 'checkout_billing_address_attributes_last_name', with: billing_address.last_name
      fill_in 'checkout_billing_address_attributes_address', with: billing_address.address
      fill_in 'checkout_billing_address_attributes_city', with: billing_address.city
      fill_in 'checkout_billing_address_attributes_zip', with: billing_address.zip
      fill_in 'checkout_billing_address_attributes_phone', with: billing_address.phone
      fill_in 'checkout_shipping_address_attributes_first_name', with: shipping_address.first_name
      fill_in 'checkout_shipping_address_attributes_last_name', with: shipping_address.last_name
      fill_in 'checkout_shipping_address_attributes_address', with: shipping_address.address
      fill_in 'checkout_shipping_address_attributes_city', with: shipping_address.city
      fill_in 'checkout_shipping_address_attributes_zip', with: shipping_address.zip
      fill_in 'checkout_shipping_address_attributes_phone', with: shipping_address.phone
      click_on(I18n.t('checkouts.addresses.show.submit'))
    end

    context 'when all fields are valid' do
      let(:billing_address) { build(:billing_address) }
      let(:shipping_address) { build(:shipping_address) }
      # let(:use_billing_address) { true }

      it 'goes to the next step' do
        expect(page).to have_content I18n.t('checkouts.steps.delivery')
      end
    end

    context 'when has invalid fields' do
      let(:billing_address) { build(:billing_address) }
      let(:shipping_address) { build(:shipping_address, first_name: '') }
      let(:use_billing_address) { false }

      it 'shows errors' do
        expect(page).to have_content 'can\'t be blank'
      end
    end
  end
end
