class OrderFactoryService
  attr_reader :cart, :checkout, :user

  def initialize(cart, checkout)
    @cart = cart
    @checkout = checkout
  end

  def create_order!
    order = Order.create!(order_attributes)
    order.attributes = { billing_address: billing_address, shipping_address: shipping_address }
    OrderMailer.with(order: order, user: checkout.user).new_order_email.deliver_now
    order
  end

  private

  def order_attributes
    { user: checkout.user, billing_address: billing_address, shipping_address: shipping_address,
      line_items: line_items, credit_card: checkout.credit_card, delivery: checkout.delivery,
      coupon: cart.coupon }
  end

  def line_items
    @cart.line_items.map do |line_item|
      LineItem.new(line_item.clone_attributes)
    end
  end

  def billing_address
    BillingAddress.new(@checkout.billing_address.clone_attributes)
  end

  def shipping_address
    ShippingAddress.new(@checkout.shipping_or_billing_address.clone_attributes)
  end
end
