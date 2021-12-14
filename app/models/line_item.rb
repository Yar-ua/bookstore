class LineItem < ApplicationRecord
  MIN_QUANTITY = 1
  REJECTED_LINE_ITEM_ATTRIBUTES = %w[id itemable_type itemable_id].freeze

  default_scope -> { order(:created_at) }

  belongs_to :book
  belongs_to :cart

  monetize :price_cents, presence: true

  validates :book, presence: true
  validates :cart, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: MIN_QUANTITY }

  def subtotal
    price * quantity
  end
  
  def clone_attributes
    attributes.reject { |attribute| REJECTED_LINE_ITEM_ATTRIBUTES.include?(attribute) }
  end
end
