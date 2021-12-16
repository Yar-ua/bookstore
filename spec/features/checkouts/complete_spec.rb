RSpec.describe 'Complete' do
  let(:complete_page) { Checkouts::CompletePage.new }
  let!(:user) { create(:user) }
  let!(:order) { create(:order, user: user) }

  before do
    login_as user, scope: :user
    visit checkouts_complete_path
  end

  context 'when visits complete page' do
    describe 'contains expected content' do
      let(:full_name) { "#{order.shipping_address.first_name} #{order.shipping_address.last_name}" }
      let(:expected_notification) do
        I18n.t('checkouts.completes.show.order_confirmation_sent', full_name: full_name, email: user.email)
      end

      it { expect(page).to have_content(order.shipping_address.first_name) }
      it { expect(page).to have_content(order.shipping_address.address) }
      it { expect(page).to have_content(order.shipping_address.phone) }
      it { expect(page).to have_content(order.shipping_address.city) }
      it { expect(page).to have_content expected_notification }
    end
  end

  context 'when click return button' do
    before do
      click_on(I18n.t('checkouts.completes.show.back'))
    end

    it 'goes to the home page' do
      expect(page).to have_content(I18n.t('home.welcome'))
    end
  end
end
