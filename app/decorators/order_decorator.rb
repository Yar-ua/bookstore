class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_associations :line_items, :credit_card, :billing_address,
                         :shipping_address, :shipping_or_billing_address

  delegate :format, to: :subtotal, prefix: :subtotal
  delegate :format, to: :total, prefix: :total
  delegate :format, to: :discount, prefix: :discount

  def created_at_formatted
    h.l(created_at, format: '%B %e, %Y')
  end
  
  def completed_at_formatted
    h.l(completed_at, format: '%Y-%m-%d') if completed_at
  end

  def status_name
    I18n.t("orders.status.#{status}")
  end

  def number
    "##{id}"
  end
end
