class OrderFactoryService
  attr_reader :cart, :checkout, :user

  def initialize(cart, checkout)
    @cart = cart
    @checkout = checkout
  end

  def create_order!
    binding.pry
    order = Order.create!(order_attributes)
    OrderMailer.with(order: order, user: checkout.user).new_order_email.deliver_now
    order
  end

  private

  #### ERROR
  # ActiveModel::MissingAttributeError (can't write unknown attribute `itemable_id`):

  def order_attributes
    # binding.pry
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