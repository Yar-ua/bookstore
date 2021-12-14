class Delivery < ApplicationRecord
  MIN_PRICE = 0

  monetize :price_cents, presence: true, numericality: { greater_than_or_equal_to: MIN_PRICE }

  validates :method, presence: true
end