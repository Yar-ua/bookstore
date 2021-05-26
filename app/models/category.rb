class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :name, length: {
    maximum: 50,
    wrong_length: I18n.t('validation.wrong_length'),
    too_long: I18n.t('validation.too_long', count: %(count))
  }
end
