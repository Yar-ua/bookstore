module Orderable
  extend ActiveSupport::Concern

  def subtotal
    line_items.reduce(Money.new(0)) { |sum, item| sum + item.subtotal }
  end

  def total
    subtotal - discount
  end

  def discount
    coupon ? subtotal * coupon.amount / 100 : Money.new(0)
  end

  def amount
    line_items.reduce(0) { |sum, item| sum + item.quantity }
  end
end