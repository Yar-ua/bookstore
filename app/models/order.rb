class Order < ApplicationRecord
  include Orderable
  include AASM

  belongs_to :user
  belongs_to :coupon, optional: true
  belongs_to :credit_card
  belongs_to :delivery

  has_one :billing_address, as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy
  has_many :line_items, as: :itemable, dependent: :destroy

  aasm column: :status do
    state :in_progress, initial: true
    state :in_queue, :in_delivery, :delivered, :canceled

    event :pay do
      transitions from: :in_progress, to: :in_queue
    end

    event :deliver do
      transitions from: :in_queue, to: :in_delivery
    end

    event :complete do
      transitions from: :in_delivery, to: :delivered, after: :set_completed_at
    end

    event :cancel do
      transitions from: %i[in_progress in_queue in_delivery], to: :canceled
    end
  end

  private

  def set_completed_at
    self.completed_at = DateTime.now
  end
end
