class CounterForm
  include ActiveModel::Model

  DEFAULT_QUANTITY = 1

  attr_reader :quantity

  validates :quantity, presence: true,
                       numericality: { only_integer: true, greater_than_or_equal_to: LineItem::MIN_QUANTITY }

  def initialize(attributes = nil)
    super
    self.quantity ||= DEFAULT_QUANTITY
  end

  def quantity=(value)
    @quantity = value.to_i
  end

  def reset
    self.quantity = DEFAULT_QUANTITY
  end
end
