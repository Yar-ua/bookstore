class CreditCard < ApplicationRecord
  CARD_BRANDS = %i[amex mastercard visa].freeze
  CVV_REGEXP = /\A\d{3,4}\z/.freeze
  OWNER_NAME_REGEXP = /\A[a-z ]*\z/i.freeze
  OWNER_NAME_MAX_LENGTH = 50
  EXPIRATION_DATE_REGEXP = %r{\A(0?[1-9]|1[0-2])/\d{2}\z}.freeze
  EXPIRATION_DATE_FORMAT = '%m/%y'.freeze

  belongs_to :user

  attr_accessor :expiration_date

  validates :number, presence: true, credit_card_number: { brands: CARD_BRANDS }
  validates :cvv, presence: true, format: { with: CVV_REGEXP }
  validates :cardholder_name, presence: true, format: { with: OWNER_NAME_REGEXP },
                              length: { maximum: OWNER_NAME_MAX_LENGTH }
  validates :expiration_date, presence: true, format: { with: EXPIRATION_DATE_REGEXP }

  after_initialize :set_expiration_date
  before_save :set_month_year

  private

  def set_expiration_date
    return if expiration_year.blank? || expiration_month.blank?

    self.expiration_date = DateTime.new(expiration_year, expiration_month).strftime(EXPIRATION_DATE_FORMAT)
  end

  def set_month_year
    return if expiration_date.blank?

    date = DateTime.strptime(expiration_date, EXPIRATION_DATE_FORMAT)
    self.expiration_month = date.month
    self.expiration_year = date.year
  end
end