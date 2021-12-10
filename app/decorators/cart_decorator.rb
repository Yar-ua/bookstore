class CartDecorator < Draper::Decorator #ApplicationDecorator
  delegate_all
  decorates_association :line_items
  delegate :format, to: :subtotal, prefix: :subtotal
  delegate :format, to: :total, prefix: :total
  delegate :format, to: :discount, prefix: :discount
end
