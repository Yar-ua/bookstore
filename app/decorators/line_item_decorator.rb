class LineItemDecorator < Draper::Decorator
  delegate_all
  decorates_association :book
  delegate :title, :price_to_currency, :short_description, :general_image_thumb, to: :book
  delegate :format, to: :subtotal, prefix: :subtotal
end
