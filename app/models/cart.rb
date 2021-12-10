class Cart < ApplicationRecord
  include Orderable

  attr_accessor :coupon_code

  belongs_to :user, optional: true
  belongs_to :coupon, optional: true
  has_many :line_items, as: :itemable, dependent: :destroy

  validates :coupon_code, coupon: true

  before_save :set_coupon, if: :coupon_code_present?

  accepts_nested_attributes_for :line_items, allow_destroy: true
  delegate :present?, to: :coupon_code, prefix: :coupon_code
  delegate :empty?, to: :line_items

  private

  def set_coupon
    self.coupon = Coupon.find_by(code: coupon_code)
  end
end