class LineItem < ApplicationRecord
  MIN_QUANTITY = 1

  default_scope -> { order(:created_at) }

  belongs_to :book
  belongs_to :itemable, polymorphic: true

  monetize :price_cents, presence: true

  validates :book, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: MIN_QUANTITY }

  def subtotal
    price * quantity
  end
end
