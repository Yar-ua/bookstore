class Book < ApplicationRecord
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships, dependent: :destroy

  validates :title, presence: true
  validates :price, presence: true, numericality: true
  validates :height, :width, :depth, numericality: true
end
