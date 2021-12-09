require 'rails_helper'

RSpec.describe Review do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end

  describe 'validations' do
    let(:valid_sentences) { ['A valid sentence', 'Сообщение', '0123456789', "#$%&'*+-/=?^_`{|}~."] }
    let(:invalid_sentences) { ['<>()[]', "multiline\n<>"] }

    it { is_expected.to validate_presence_of(:score) }
    it { is_expected.to validate_inclusion_of(:score).in_range(Review::SCORE_RANGE) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(Review::MAX_TITLE_LENGTH) }
    it { is_expected.to allow_values(*valid_sentences).for(:title) }
    it { is_expected.not_to allow_values(*invalid_sentences).for(:title) }

    it { is_expected.to validate_presence_of(:message) }
    it { is_expected.to validate_length_of(:message).is_at_most(Review::MAX_MESSAGE_LENGTH) }
    it { is_expected.to allow_values(*valid_sentences).for(:message) }
    it { is_expected.not_to allow_values(*invalid_sentences).for(:message) }
  end
end
