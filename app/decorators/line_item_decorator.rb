# ApplicationDecorator
class LineItemDecorator < Draper::Decorator
  delegate_all
  decorates_association :book
  delegate :title, :price_to_currency, :general_image_thumb, to: :book, prefix: :book
  delegate :format, to: :subtotal, prefix: :subtotal
end
