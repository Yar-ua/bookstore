require 'aasm/rspec'

RSpec.describe Order do
  let(:order) { described_class.new }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:coupon).optional }
    it { is_expected.to belong_to(:delivery) }
    it { is_expected.to belong_to(:credit_card) }
    it { is_expected.to have_many(:line_items) }
    it { is_expected.to have_one(:billing_address) }
    it { is_expected.to have_one(:shipping_address) }
  end

  describe 'state machine' do
    it do
      expect(order).to transition_from(described_class::STATE_IN_PROGRESS)
        .to(described_class::STATE_IN_QUEUE).on_event(:pay)
    end

    it do
      expect(order).to transition_from(described_class::STATE_IN_QUEUE)
        .to(described_class::STATE_IN_DELIVERY).on_event(:deliver)
    end

    it do
      expect(order).to transition_from(described_class::STATE_IN_DELIVERY)
        .to(described_class::STATE_DELIVERED).on_event(:complete)
    end

    it do
      expect(order).to transition_from(described_class::STATE_IN_PROGRESS)
        .to(described_class::STATE_CANCELED).on_event(:cancel)
    end

    it do
      expect(order).to transition_from(described_class::STATE_IN_QUEUE)
        .to(described_class::STATE_CANCELED).on_event(:cancel)
    end

    it do
      expect(order).to transition_from(described_class::STATE_IN_DELIVERY)
        .to(described_class::STATE_CANCELED).on_event(:cancel)
    end
  end
end
