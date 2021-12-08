class Book < ApplicationRecord
  BOOKS_IN_GROUP = 4
  MIN_NUMBER = 0
  MAX_PUBLICATION_YEAR = DateTime.now.year
  MIN_PUBLICATION_YEAR = 1900

  enum material: %i[papers silk carboard]

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books, dependent: :destroy
  has_many :reviews, dependent: :destroy

  belongs_to :category, counter_cache: true

  validates :title, :description, :height, :width, :depth, :category, :year, presence: true
  validates :height, :width, :depth, :price, :quantity,
            presence: true, numericality: { greater_than_or_equal_to: MIN_NUMBER }

  def approved_reviews
    reviews.approved
  end
end
