RSpec.describe Book do
  let(:book) { create(:book) }

  describe 'validation' do
    it { expect(book).to validate_presence_of(:title) }
    it { expect(book).to validate_presence_of(:price) }
    it { expect(book).to validate_numericality_of(:price) }
    it { expect(book).to validate_numericality_of(:quantity) }
    it { expect(book).to validate_numericality_of(:height) }
    it { expect(book).to validate_numericality_of(:width) }
    it { expect(book).to validate_numericality_of(:depth) }
  end

  describe 'with assosiations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:author_books).dependent(:destroy) }
    it { is_expected.to have_many(:authors).through(:author_books) }
  end
end
