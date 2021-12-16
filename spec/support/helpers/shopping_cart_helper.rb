module ShoppingCartHelper
  def stub_cart(*args, **kwargs)
    cart = create(:cart, *args, **kwargs)
    session[ShoppingCartService::CART_SESSION_KEY] = cart.id
    cart
  end

  def stub_checkout(*args, **kwargs)
    checkout = create(:checkout, *args, **kwargs)
    session[Checkouts::MasterController::CHECKOUT_SESSION_ID] = checkout.id
    checkout
  end
end
