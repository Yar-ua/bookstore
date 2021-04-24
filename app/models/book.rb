class Book < ApplicationRecord
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships, dependent: :destroy

  belongs_to :category, counter_cache: true

  validates :title, :description, presence: true
  validates :price, presence: true, numericality: true
  validates :height, :width, :depth, numericality: true
end
