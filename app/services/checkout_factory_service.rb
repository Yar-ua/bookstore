class CheckoutFactoryService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def create_checkout!
    Checkout.create!(checkout_attributes)
  end

  private

  def checkout_attributes
    { user: user, billing_address: billing_address,
      shipping_address: shipping_address, delivery: delivery }
  end

  def billing_address
    BillingAddress.new(user.billing_address.clone_attributes) if user.billing_address
  end

  def shipping_address
    ShippingAddress.new(user.shipping_address.clone_attributes) if user.shipping_address
  end

  def delivery
    Delivery.first
  end
end