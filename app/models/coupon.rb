class Coupon < ApplicationRecord
  AMOUNT_RANGE = (1..100).freeze

  has_many :carts, dependent: :nullify

  validates :code, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: { only_integer: true,
                                                     greater_than_or_equal_to: AMOUNT_RANGE.min,
                                                     less_than_or_equal_to: AMOUNT_RANGE.max }
end