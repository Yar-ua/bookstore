class Address < ApplicationRecord
  NAME_REGEXP = /\A[a-zA-Z]*\z/.freeze
  ADDRESS_REGEXP = /\A[a-zA-Z0-9 \-,]*\z/.freeze
  ZIP_REGEXP = /\A[0-9\-]*\z/.freeze
  PHONE_REGEXP = /\A\+[0-9]*\z/.freeze
  REJECTED_ATTRIBUTES = %w[id type addressable_type addressable_id].freeze

  belongs_to :user, optional: true
  belongs_to :addressable, polymorphic: true

  validates :first_name, :last_name,
            presence: true,
            format: { with: NAME_REGEXP,
                      message: 'Consist of a-z, A-Z only, no special symbols' },
            length: { maximum: 50 }

  validates :address, :city, :country,
            presence: true,
            format: { with: ADDRESS_REGEXP,
                      message: 'Consist of a-z, A-Z, 0-9,’,’, ‘-’, ‘ ’ only, \
                      no special symbols' },
            length: { maximum: 50 }

  validates :zip,
            presence: true,
            format: { with: ZIP_REGEXP,
                      message: 'Consist of 0-9 only,’-’ no special symbols' },
            length: { maximum: 10 }

  validates :phone,
            presence: true,
            format: { with: PHONE_REGEXP,
                      message: 'Consist of 0-9 only no special symbols, and + on beginning' },
            length: { maximum: 15 }
  def country_name
    country = ISO3166::Country[country]
    country&.translations&.dig(I18n.locale.to_s) || country&.name
  end

  def clone_attributes
    attributes.reject { |attribute| REJECTED_ATTRIBUTES.include?(attribute) }
  end

  private

  def normalize_phone
    return if phone.blank?

    self.phone = "+#{TelephoneNumber.parse(phone, country_code).international_number(formatted: false)}"
  end
end
