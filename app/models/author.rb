class Author < ApplicationRecord
  has_many :author_books, dependent: :destroy
  has_many :books, through: :author_books, dependent: :destroy

  validates :first_name, :last_name, presence: true
  validates :first_name, :last_name, length: {
    maximum: 50,
    wrong_length: I18n.t('validation.wrong_length'),
    too_long: I18n.t('validation.too_long', count: %(count))
  }
end
