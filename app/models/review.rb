class Review < ApplicationRecord
  SCORE_RANGE = (1..5).freeze
  MAX_TITLE_LENGTH = 50
  MAX_MESSAGE_LENGTH = 500
  SENTENCE_REGEX = %r{\A[\w\sа-я!#$%&'*+\-/=?^`{|}~.]*\z}i.freeze

  default_scope -> { order(created_at: :desc) }
  enum status: { unprocessed: 0, approved: 1, rejected: 2 }

  belongs_to :user
  belongs_to :book

  validates :score, presence: true, inclusion: { in: SCORE_RANGE }
  validates :title, presence: true, length: { maximum: MAX_TITLE_LENGTH }, format: { with: SENTENCE_REGEX }
  validates :message, presence: true, length: { maximum: MAX_MESSAGE_LENGTH }, format: { with: SENTENCE_REGEX }
end
