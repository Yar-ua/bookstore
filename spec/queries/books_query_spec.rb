RSpec.describe BooksQuery do
  let(:category) { create(:category) }
  let!(:book1) { create(:book, title: 'A', category: category, price: 10) }
  let!(:book2) { create(:book, title: 'B', category: category, price: 5) }
  let(:sort_books) { described_class }

  describe 'sorting books' do
    it { expect(described_class.new(sort: :newest).call).to eq([book2, book1]) }
    it { expect(described_class.new(sort: :popular).call).to eq([book1, book2]) }
    it { expect(described_class.new(sort: :title_z_a).call).to eq([book2, book1]) }
    it { expect(described_class.new(sort: :title_a_z).call).to eq([book1, book2]) }
    it { expect(described_class.new(sort: :price_low_high).call).to eq([book2, book1]) }
    it { expect(described_class.new(sort: :price_high_low).call).to eq([book1, book2]) }
  end
end
