class Address < ApplicationRecord
  NAME_REGEXP = /\A[a-zA-Z]*\z/.freeze
  ADDRESS_REGEXP = /\A[a-zA-Z0-9 \-,]*\z/.freeze
  ZIP_REGEXP = /\A[0-9\-]*\z/.freeze
  PHONE_REGEXP = /\A\+[0-9]*\z/.freeze

  belongs_to :user
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
end
