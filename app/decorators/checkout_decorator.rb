class CheckoutDecorator < Draper::Decorator
  delegate_all
  decorates_associations :line_items, :credit_card, :billing_address,
                         :shipping_address, :shipping_or_billing_address
end
