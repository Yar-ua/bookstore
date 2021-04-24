RSpec.describe SortBooks do
  let(:category) { create(:category) }
  let!(:book1) { create(:book, title: 'A', category: category, price: 10) }
  let!(:book2) { create(:book, title: 'B', category: category, price: 5) }
  let(:sort_books) { described_class.new }

  describe 'sorting books' do
    it { expect(sort_books.sort(sort: :newest)).to eq([book2, book1]) }
    it { expect(sort_books.sort(sort: :popular)).to eq([book1, book2]) }
    it { expect(sort_books.sort(sort: :title_z_a)).to eq([book2, book1]) }
    it { expect(sort_books.sort(sort: :title_a_z)).to eq([book1, book2]) }
    it { expect(sort_books.sort(sort: :price_low_high)).to eq([book2, book1]) }
    it { expect(sort_books.sort(sort: :price_high_low)).to eq([book1, book2]) }
  end

  describe 'current sorting' do
    it {
      expect(sort_books.current_sort(sort: :newest)).to eq({ title: I18n.t('sort.newest'), order: :created_at,
                                                             by: :desc })
    }
  end
end
