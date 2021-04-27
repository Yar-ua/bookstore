class Book < ApplicationRecord
  BOOKS_IN_GROUP = 4
  MATERIALS = %w[papers silk carboard].freeze

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books, dependent: :destroy

  belongs_to :category, counter_cache: true

  validates :title, :description, presence: true
  validates :price, :quantity, presence: true, numericality: true
  validates :height, :width, :depth, presence: true, numericality: true
end
