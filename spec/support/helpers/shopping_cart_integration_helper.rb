module ShoppingCartIntegrationHelper
  def stub_cart(user, *args, **kwargs)
    create(:cart, *args, user: user, **kwargs)
  end

  def stub_checkout(user, **attributes)
    prev_url = current_url
    visit checkouts_address_path
    Checkout.where(user: user).last.update!(attributes)
    visit prev_url if prev_url.present?
  end

  def stub_checkout_with_data(user, **attributes)
    defaults = { billing_address: build(:billing_address), shipping_address: build(:shipping_address),
                 credit_card: build(:credit_card, user: user), delivery: build(:delivery) }
    stub_checkout(user, defaults.merge(attributes))
  end

  def user_checkout(user)
    Checkout.where(user: user).last
  end
end