require 'rails_helper'

RSpec.describe ShoppingCartService do
  subject(:shopping_cart) { described_class.new(session, user) }

  let(:user) { nil }
  let(:session) { ActionController::TestSession.new }

  describe '#current_cart' do
    it 'returns Cart object' do
      expect(shopping_cart.current_cart).to be_a(Cart)
    end
  end

  describe '#add_book' do
    let(:cart) { create(:cart, line_items: line_items) }
    let(:book) { create(:book) }

    before do
      shopping_cart.instance_variable_set(:@current_cart, cart)
    end

    context 'when cart is empty' do
      let(:line_items) { [] }

      it 'changes items size' do
        expect { shopping_cart.add_book(book) }.to change { cart.line_items.size }.from(0).to(1)
      end
    end

    context 'when cart has the same book' do
      let(:line_items) { [build(:line_item, book: book, quantity: 2)] }

      # rubocop:disable Lint/AmbiguousBlockAssociation
      it 'does not change items size' do
        expect { shopping_cart.add_book(book) }.not_to change { cart.line_items.size }
      end

      # rubocop:enable Lint/AmbiguousBlockAssociation
      it 'increases quantity' do
        expect { shopping_cart.add_book(book) }.to change { cart.line_items.first.quantity }.from(2).to(3)
      end
    end
  end
end
