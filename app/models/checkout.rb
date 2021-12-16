class Checkout < ApplicationRecord
  STAGES = {
    new: 'new',
    address: 'address',
    delivery: 'delivery',
    payment: 'payment'
  }.freeze

  belongs_to :delivery, optional: true
  belongs_to :credit_card, optional: true
  belongs_to :user

  has_one :billing_address, as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy

  validates :billing_address, presence: true, if: :address_stage?
  validates :shipping_address, presence: true, if: :require_shipping_address?
  validates :delivery, presence: true, if: :delivery_stage?
  validates :credit_card, presence: true, if: :payment_stage?

  accepts_nested_attributes_for :billing_address, :shipping_address, :credit_card

  before_validation :remove_shipping_address, if: :use_billing_address

  def shipping_or_billing_address
    shipping_address || billing_address
  end

  private

  def remove_shipping_address
    self.shipping_address = nil
  end

  def delivery_stage?
    stage == STAGES[:delivery]
  end

  def address_stage?
    stage == STAGES[:address]
  end

  def payment_stage?
    stage == STAGES[:payment]
  end

  def require_shipping_address?
    address_stage? && !use_billing_address
  end
end
